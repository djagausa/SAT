class HomeController < ApplicationController
   	def index
   		if !params[:home].nil?
   			@products=Product.get_products(	"category_ids" => params[:home][:category_ids][0...-1],
 										"zip_code" => params[:home][:zip_code],
 										"distance" => params[:home][:distance],
 										"page" => params[:page])
   		else
  			@products=Product.get_products("page" => params[:page])
  		end
  	end

 	def create
 		@products=Product.get_products(	"category_ids" => params[:home][:category_ids][0...-1],
 										"zip_code" => params[:home][:zip_code],
 										"distance" => params[:home][:distance],
 										"page" => params[:page])
 	end
end
