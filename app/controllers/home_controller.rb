class HomeController < ApplicationController
   	def index
  		@products=Product.get_products("page" => params[:page])
  	end

 	def create
 		@products=Product.get_products(	"category_ids" => params[:home][:category_ids][0...-1],
 										"zip_code" => params[:home][:zip_code],
 										"distance" => params[:home][:distance],
 										"page" => params[:page])
 	end
end
