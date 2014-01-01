class Store < ActiveRecord::Base
  	acts_as_mappable
	before_validation	:geocode_address
	belongs_to  		:biz
	has_many			:products, through: :biz
  	validates			:zip_code, presence: true


	private

  	def complete_address
  		"#{self.street1}, #{self.street2}, #{self.city}, #{self.state}, #{self.zip_code}"
  	end
  	def geocode_address
    	geo=Geokit::Geocoders::MultiGeocoder.geocode (complete_address)
      	errors.add(:address, "Could not Geocode address") if !geo.success
   		self.lat, self.lng = geo.lat,geo.lng if geo.success
  	end
	
end
