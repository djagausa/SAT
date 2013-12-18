class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :biz
	has_many :stores, through: :biz

	

	validates :name, presence: true, uniqueness: true
	validates :original_price, :sale_price, :from_date, :to_date, presence:  true

	has_attached_file 	:photo, :styles => { :small => "150x150>", :medium => "300x300>" }
						# :url => ":rails_root/public/assets/prducts/:id/:style/:basename.:extension",
						# :path => ":rails_root/public/assets/prducts/:id/:style/:basename.:exttension"

	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

	# scope :not_expired, -> {where('products.to_date >= ?', Date.today()).includes(:biz).order(:to_date).all}

	scope :by_biz_id, -> (id) {where('biz_id = ?', id)}

end
