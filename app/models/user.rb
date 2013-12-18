class User < ActiveRecord::Base
	acts_as_superclass

	before_save { self.email = email.downcase }
	before_create { generate_token(:auth_token) }
 	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

 	has_secure_password
 	validates :password, length: { minimum: 6 }, :on => :create

 	scope :by_email, ->(email) {where("email = ?", email)}

 	scope :find_user, -> (id, user_type) {where('as_user_id = ? and as_user_type = ?', id, user_type).first}

 	# class method that checks whether the user's email and submitted_password are valid
	def self.authenticate(email, submitted_password)
	  	user = find_by_email(email)

	   	return nil if user.nil?
	   	return user if user.authenticate(submitted_password)
	end
	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

end
