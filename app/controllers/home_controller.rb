class HomeController < ApplicationController
   	def index
  		@stores=Store.products_not_expired
  	end

 	def create
 		@stores=Store.get_products("category_ids" => params[:home][:category_ids][0...-1],"zip_code" => params[:home][:zip_code],"distance" => params[:home][:distance])
 	end
end
