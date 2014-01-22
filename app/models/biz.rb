class Biz < ActiveRecord::Base
	acts_as 	:user
	has_many 	:bizizations
	has_many 	:shoppers, through: :bizization
	has_many 	:stores
	has_many 	:products

	validates :name, presence: true
 	validates_acceptance_of :terms_of_service, allow_nil: false


	has_attached_file 	:logo, :styles => { :small => "150x150>", :medium => "300x300>" }
						# :url => ":rails_root/public/assets/prducts/:id/:style/:basename.:extension",
						# :path => ":rails_root/public/assets/prducts/:id/:style/:basename.:exttension"

	validates_attachment_size :logo, :less_than => 5.megabytes
	validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
	
 	accepts_nested_attributes_for :stores

	scope :find_biz, -> (biz_id) {find(biz_id)} 

	apply_simple_captcha
end
