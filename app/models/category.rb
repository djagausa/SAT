class Category < ActiveRecord::Base
	has_many :products
	has_many :shoppers

	has_many :categorizations
  	has_many :shoppers, through: :categorizations

	validates :name, presence: true, uniqueness: true

	scope :all_in_order, -> {all.order(name: :asc)}
	
end
