class Biz < ActiveRecord::Base
	has_many :bizizations
	has_many :shoppers, through: :bizization
	has_many :stores
	has_many :products

	before_save { self.email = email.downcase }

	validates :name, presence: true

	has_attached_file 	:logo, :styles => { :small => "150x150>", :medium => "300x300>" }
						# :url => ":rails_root/public/assets/prducts/:id/:style/:basename.:extension",
						# :path => ":rails_root/public/assets/prducts/:id/:style/:basename.:exttension"

	validates_attachment_size :logo, :less_than => 5.megabytes
	validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

 	has_secure_password
 	validates :password, length: { minimum: 6 }

 	scope :by_email, ->(email) {where("email = ?", email)}

 	accepts_nested_attributes_for :stores

 	# class method that checks whether the user's email and submitted_password are valid
	def self.authenticate(email, submitted_password)
	  	user = find_by_email(email)

	   	return nil if user.nil?
	   	return user if user.authenticate(submitted_password)
	end

end
