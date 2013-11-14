json.array!(@stores) do |store|
  json.extract! store, :name, :street1, :street2, :city, :state, :zip, :phone, :contact, :hours, :days
  json.url store_url(store, format: :json)
end
