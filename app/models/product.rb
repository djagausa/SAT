class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :biz
	has_many :stores, through: :biz

	validates :name, presence: true
	validates :original_price, :sale_price, :from_date, :to_date, presence:  true

	has_attached_file 	:photo, :styles => { :small => "150x150>", :medium => "300x300>" }
						# :url => ":rails_root/public/assets/prducts/:id/:style/:basename.:extension",
						# :path => ":rails_root/public/assets/prducts/:id/:style/:basename.:exttension"

	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

	scope :by_biz_id, -> (id, page) {where('biz_id = ?', id).order('to_date').page(page).per(5)}

	acts_as_mappable :through => :stores

	scope :select_by_zip_code, -> (zip_code, page) \
		{Product.all.includes(:stores,:biz). \
					where(:stores => {:zip_code => zip_code}). \
					where('to_date >= ?', Date.today()).order('to_date').page(page).per(5)}
	
	scope :select_by_zip_cat, -> (zip_code,cat, page) \
		{Product.all.includes(:stores,:biz). \
					where('to_date >= ?', Date.today()). \
					where(:stores => {:zip_code => zip_code}). \
					where(:products => {:category_id => cat}).order('to_date').page(page).per(5)}

	scope :products_not_expired, -> (page) {Product.all.includes(:stores, :biz). \
		where('to_date >= ?', Date.today()).order('to_date').page(page).per(5)}

	scope :select_by_zip_distance, -> (zip, distance, page) \
		{Product.within(distance, :origin=>zip).includes(:stores, :biz). \
			where('to_date >= ?', Date.today()).order('to_date').page(page).per(5)}

	scope :select_by_zip_distance_cat, -> (zip,distance,cat, page) \
		{Product.within(distance, :origin=>zip).includes(:stores, :biz). \
					where({:products => {:category_id => cat}}). \
					where('to_date >= ?', Date.today()).order('to_date').page(page).per(5)}

	scope :select_by_cat, -> (cat, page) \
		{Product.all.includes(:stores, :biz).where({:products => {:category_id => cat}}).\
					where('to_date >= ?', Date.today()).order('to_date').page(page).per(5)}

	def self.get_products (search_params)
logger.debug "**********************************  #{search_params} "
logger.debug "**********************************  search_params #{search_params['category_ids']} #{search_params['distance']}  #{search_params['zip_code']}   "
		
		cnt = 0
		if search_params.count > 1
			cnt +=1 if search_params['zip_code'] != ""
			cnt +=2	if search_params['category_ids'] != []
		end
# logger.debug "************************************     search count  #{cnt}"
		case 
		when cnt == 0
			Product.products_not_expired(search_params['page'])
		when cnt == 1
			if search_params['distance'].nil? || search_params['distance'] == ""
# logger.debug "************************************     search zip only #{search_params['zip_code']}"
				Product.select_by_zip_code(search_params['zip_code'], search_params['page'])
			else
# logger.debug "************************************     search zip and distance #{search_params['zip_code']} #{search_params['distance']}"
				Product.select_by_zip_distance(search_params['zip_code'],search_params['distance'],search_params['page'])
			end
		when cnt == 2
			Product.select_by_cat(search_params['category_ids'],search_params['page'])
		when cnt == 3
			if search_params['distance'] == ""
				Product.select_by_zip_cat(search_params['zip_code'],search_params['category_ids'],search_params['page'])
			else
				Product.select_by_zip_distance_cat(search_params['zip_code'],search_params['distance'],search_params['category_ids'],search_params['page'])
			end
		end
	end
end
