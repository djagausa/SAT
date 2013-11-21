class HomeController < ApplicationController
   	def index
  		@stores=Store.products_not_expired
  	end

 	def create
 		@stores=Store.get_products(params)
 	end
end
