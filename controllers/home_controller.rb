class HomeController < Controller
  def index
    response.write "Hello from home!"
  end
  
  def nice
    response.write "This is nice!"
  end
end