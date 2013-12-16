class Shopper < ActiveRecord::Base
	acts_as 	:user
	has_many 	:bizizations
	has_many 	:bizs, through: :bizizations

	has_many 	:categorizations
  	has_many 	:categories, through: :categorizations

	acts_as_mappable :auto_geocode => {:field=>:zip_code}

	scope :find_shopper, -> (shopper_id) {find(shopper_id)} 
end

