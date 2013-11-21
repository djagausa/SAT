class Store < ActiveRecord::Base
	belongs_to :biz
	has_many	:products, through: :biz

  	validates	:zip_code, presence: true
  	
	geocoded_by :zip_code
	after_validation :geocode, :if => :zip_code_changed?

	scope :select_by_zip, -> (zip_code) \
			{(Store.near(zip_code).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).uniq)}

	scope :select_by_zip_distance, -> (zip_code, distance)	\
		{Store.near(zip_code, distance).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).uniq}

	scope :select_by_zip_distance_cat, -> (zip_code, distance, cat) \
		{Store.near(zip_code, distance).includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:products => {:category_id => cat}).uniq}

	scope :select_by_cat, -> (cat) \
		{Store.includes(:products,:biz).joins(:products => :biz).where('products.to_date >= ?', Date.today()).where(:products => {:category_id => cat}).uniq}

	def self.products_not_expired
		Store.all.includes(:products, :biz)
	end

	def self.get_products (params)
		cnt = 0
		if !params.empty?
			cnt +=1 if params[:home][:zip_code] != ''
			cnt +=2	if params[:home][:category_ids] != [""]
		end

		case 
		when cnt == 0
			Store.all.includes(:products, :biz)
		when cnt == 1
			Store.select_by_zip_distance(params[:home][:zip_code],params[:home][:distance])
		when cnt == 2
			Store.select_by_cat(params[:home][:category_ids][0...-1])
		when cnt == 3
			Store.select_by_zip_distance_cat(params[:home][:zip_code],params[:home][:distance],params[:home][:category_ids][0...-1])
		end
	end	
end
