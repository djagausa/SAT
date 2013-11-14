class Categorization < ActiveRecord::Base
	belongs_to :shopper
  	belongs_to :category
end
