class HomeController < ApplicationController
   def index
  	@products=Product.not_expired
  	@categories=Category.all(:order => "name ASC")

  end

  def create
	respond_to do |format|
		format.js {@zip=params[:zip_code], @distance=params[:distance]}
	end
  end
end
