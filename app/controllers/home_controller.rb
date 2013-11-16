class HomeController < ApplicationController
   def index
  	@products=Product.not_expired

  end

  def create
	respond_to do |format|
        
		format.js {@zip=params[:zip_code], @distance=params[:distance], @product_cats = params[:store][:category_ids][0...-1] }
	end
  end
end
