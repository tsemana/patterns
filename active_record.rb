require "connection_adapter"

module ActiveRecord
  class Base
    @@connection = SqliteAdapter.new

    def initialize(attributes)
      @attributes = attributes
    end
    
    def method_missing(name, *args)
      if self.class.columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.find(id)
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
    end

    def self.all
      find_by_sql("SELECT * FROM #{table_name}")
    end

    def self.find_by_sql(sql)
      rows = @@connection.execute(sql) # [[1, "Marc"]]
      rows.map do |row|
        # row = [1, "Marc"]
        attributes = map_values_to_columns(row)
        new(attributes)
      end
    end

    def self.map_values_to_columns(values)
      Hash[columns.zip(values)]
    end

    def self.columns
      @@connection.columns(table_name)
    end
    
    def self.table_name
      name.downcase + "s"
    end
    
    def self.scoped
      Relation.new(self)
    end
    
    def self.where(condition)
      scoped.where(condition)
    end
  end
  
  class Relation
    attr_accessor :conditions
    
    def initialize(klass)
      @klass = klass
      @conditions = [] # where
    end
    
    def where(condition)
      relation = self.clone
      relation.conditions += [condition]
      relation
    end
    
    def to_sql
      sql = "SELECT * FROM #{@klass.table_name}"
      if @conditions.any?
        sql << " WHERE " + @conditions.join(" AND ")
      end
      sql
    end
    
    def method_missing(name, *args, &block)
      if Array.method_defined?(name)
        array = @klass.find_by_sql(to_sql)
        array.send(name, *args, &block)
      else
        super
      end
    end
  end
end

