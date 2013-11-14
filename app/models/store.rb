class Store < ActiveRecord::Base
	belongs_to :biz

  	validates	:zip_code, presence: true
  	
	geocoded_by :zip_code
	after_validation :geocode, :if => :zip_code_changed?	
end
