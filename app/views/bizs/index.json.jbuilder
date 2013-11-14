json.array!(@bizs) do |biz|
  json.extract! biz, :name, :email, :web_site
  json.url biz_url(biz, format: :json)
end
