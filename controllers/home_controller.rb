class HomeController < Controller
  before_filter :header
  after_filter  :footer
  
  def index
    @message = "this is a message"
    render :index
  end
  
  def nice
    response.write "This is nice!"
  end
  
  def header
    response.write "<h1>My App</h1>"
  end
  
  def footer
    response.write "<p>&copy; me</p>"
  end
end