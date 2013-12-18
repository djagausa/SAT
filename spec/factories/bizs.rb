# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :biz do
  		user
		name 		{ Faker::Name.name }
		website 	{ Faker::Internet.url}
		logo_image 	"logo.img"

		factory :invalid_biz do
			name ""
		end
	end
end
