class Category < ActiveRecord::Base
	has_many :products
	has_many :shoppers

	has_many :categorizations
  	has_many :shoppers, through: :categorizations

	validates :name, presence: true, uniqueness: true
end
