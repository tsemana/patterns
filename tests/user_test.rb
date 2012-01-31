require File.dirname(__FILE__) + '/test_helper'
require "active_record"
require "models/user"

class UserTest < Test::Unit::TestCase
  def test_initalize_with_attributes
    user = User.new(:id => 1, :name => "Marc")
    assert_equal 1, user.id
    assert_equal "Marc", user.name
  end
  
  def test_find
    user = User.find(1)
    assert_equal 1, user.id
  end
  
  def test_all
    user = User.all.first
    assert_equal 1, user.id
  end
  
  def test_map_values_to_columns
    columns = [:id, :name]
    values = [1, "Marc"]
    
    expected = { :id => 1, :name => "Marc" }
    
    attributes = User.map_values_to_columns(values)
    
    assert_equal expected, attributes
  end
  
  def test_columns
    assert_equal [:id, :name], User.columns
  end
  
  def test_table_name
    assert_equal "users", User.table_name
  end
end