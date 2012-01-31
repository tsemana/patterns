class HomeController < Controller
  def index
    response.write "Hi from home controller"
  end
  
  def nice
    response.write "This is nice"
  end
end