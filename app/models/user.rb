class User < ActiveRecord::Base
	acts_as_superclass

	before_save { self.email = email.downcase }
 	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

 	has_secure_password
 	validates :password, length: { minimum: 6 }

 	scope :by_email, ->(email) {where("email = ?", email)}

 	# class method that checks whether the user's email and submitted_password are valid
	def self.authenticate(email, submitted_password)
	  	user = find_by_email(email)

	   	return nil if user.nil?
	   	return user if user.authenticate(submitted_password)
	end
	def send_password_reset
		UserMailer.password_reset(self).deliver
	end

end
