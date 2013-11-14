json.array!(@shoppers) do |shopper|
  json.extract! shopper, :name, :email, :zip_code, :miles, :home_page, :type
  json.url shopper_url(shopper, format: :json)
end
