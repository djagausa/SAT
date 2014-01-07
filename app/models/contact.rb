class Contact
	include ActiveModel::Model

	attr_accessor :name, :email, :message
	
	validates :name, 	presence: true
	validates :email, 	presence: true
	validates :message,	presence: true, length: { maximum: 300 }
	validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

end