# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shopper do
    email 			"MyString"
    password_digest "MyString"
    home_page 		false
    zip_code 		"MyString"
    longitude 		1.5
    latitude 		1.5
    distance 		1
  end
end
