class Store < ActiveRecord::Base
	belongs_to :biz
	has_many	:products, through: :biz

  	validates	:zip_code, presence: true
  	
  	acts_as_mappable :auto_geocode => {:field=>:complete_address}

  	def complete_address
  		"#{self.street1}, #{self.street2}, #{self.city}, #{self.state}, #{self.zip_code}"
  	end
	# scope :select_by_zip, -> (zip_code) \
	# 		{(Store.near(zip_code).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).uniq)}

	# scope :select_by_zip_distance, -> (zip_code, distance)	\
	# 	{Store.near(zip_code).includes(:products,:biz).joins(:products => :biz).uniq}

	# scope :select_by_zip_distance_cat, -> (zip_code, distance, cat) \
	# 	{Store.near(zip_code, distance).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:products => {:category_id => cat}).uniq}

	scope :select_by_cat, -> (cat) \
		{Store.includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:products => {:category_id => cat}).uniq}

	def self.products_not_expired
		@stores = Store.all.includes(:products, :biz).where('products.to_date >= ?', Date.today())
	end

	def self.select_by_zip_distance (zip, distance)
		@stores=Store.within(distance, :origin=>zip).includes(:products, :biz).where('products.to_date >= ?', Date.today())
	end

	def self.select_by_zip_distance_cat (zip,distance,cat)
		@stores=Store.within(distance, :origin=>zip).includes(:products, :biz).where({:products => {:category_id => cat}}).where('products.to_date >= ?', Date.today())
	end

	def self.select_by_cat(cat)
		@stores=Store.all.includes(:products, :biz).where({:products => {:category_id => cat}}).where('products.to_date >= ?', Date.today())
	end

	def self.get_products (params)
		logger.debug("************************************ params #{params}")
		cnt = 0
		if !params.empty?
			cnt +=1 if params[:home][:zip_code] != ''
			cnt +=2	if params[:home][:category_ids] != [""]
			params[:home][:distance] = 0 if params[:home][:distance] == ''
		end

		case 
		when cnt == 0
			Store.products_not_expired
		when cnt == 1
			Store.select_by_zip_distance(params[:home][:zip_code],params[:home][:distance])
		when cnt == 2
			Store.select_by_cat(params[:home][:category_ids][0...-1])
		when cnt == 3
			Store.select_by_zip_distance_cat(params[:home][:zip_code],params[:home][:distance],params[:home][:category_ids][0...-1])
		end
	end	
end
