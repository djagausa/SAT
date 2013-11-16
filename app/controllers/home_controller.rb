class HomeController < ApplicationController
   def index
  	@products=Product.not_expired
  end

end
