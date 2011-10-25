$:.unshift "." # Fix for 1.9 require
require "front_controller"

run FrontController.new