# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

	factory :shopper do
		user
		zip_code 	{ Faker::Address.zip }
		distance 	{ Faker::Number.number(3) }
		home_page 	true
	end
end