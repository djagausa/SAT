# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
 factory :product do
		name				{ Faker::Name.name }
		description			{ Faker::Lorem.paragraph }
		original_price		{ Faker::Number.number(5) }
		sale_price			{ Faker::Number.number(5) }
		from_date			"2003-03-01"
		to_date				"2004-04-04"
		category
		biz
	end

end
