class Store < ActiveRecord::Base
  	acts_as_mappable
	before_validation	:geocode_address
	belongs_to  		:biz
	has_many			:products, through: :biz
  	validates			:zip_code, presence: true

	# scope :select_by_zip, -> (zip_code) \
	# 		{(Store.near(zip_code).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).uniq)}

	# scope :select_by_zip_distance, -> (zip_code, distance)	\
	# 	{Store.near(zip_code).includes(:products,:biz).joins(:products => :biz).uniq}

	# scope :select_by_zip_distance_cat, -> (zip_code, distance, cat) \
	# 	{Store.near(zip_code, distance).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:products => {:category_id => cat}).uniq}

	scope :select_by_cat, -> (cat) \
		{Store.includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:products => {:category_id => cat}).uniq}

	scope :select_by_zip_code, -> (zip_code) \
		{Store.includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:stores => {:zip_code => zip_code}).uniq}
	
	scope :select_by_zip_cat, -> (zip_code,cat) \
		{Store.includes(:products,:biz).joins(:products => :biz). \
					where('products.to_date >= ?', Date.today()). \
					where(:stores => {:zip_code => zip_code}). \
					where(:products => {:category_id => cat}).uniq}


	scope :products_not_expired, -> {Store.all.includes(:products, :biz).where('products.to_date >= ?', Date.today())}

	scope :select_by_zip_distance, -> (zip, distance) \
		{Store.within(distance, :origin=>zip).includes(:products, :biz).where('products.to_date >= ?', Date.today())}

	scope :select_by_zip_distance_cat, -> (zip,distance,cat) \
		{Store.within(distance, :origin=>zip).includes(:products, :biz). \
					where({:products => {:category_id => cat}}). \
					where('products.to_date >= ?', Date.today())}

	scope :select_by_cat, -> (cat) \
		{Store.all.includes(:products, :biz).where({:products => {:category_id => cat}}).where('products.to_date >= ?', Date.today())}

	def self.get_products (search_params)
		logger.debug "**********************************  #{search_params} "
		logger.debug "**********************************  search_params #{search_params['category_ids']} #{search_params['distance']}  #{search_params['zip_code']}   "
		cnt = 0
		if !search_params.empty?
			cnt +=1 if search_params['zip_code'] != ""
			cnt +=2	if search_params['category_ids'] != []
		end

		case 
		when cnt == 0
			Store.products_not_expired
		when cnt == 1
			if search_params['distance'] == ""
				Store.select_by_zip_code(search_params['zip_code'])
			else
				Store.select_by_zip_distance(search_params['zip_code'],search_params['distance'])
			end
		when cnt == 2
			Store.select_by_cat(search_params['category_ids'])
		when cnt == 3
			if search_params['distance'] == ""
				Store.select_by_zip_cat(search_params['zip_code'],search_params['category_ids'])
			else
				Store.select_by_zip_distance_cat(search_params['zip_code'],search_params['distance'],search_params['category_ids'])
			end
		end
	end

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
