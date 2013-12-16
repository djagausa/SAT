# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :biz do
		# email 		{ Faker::Internet.email }
		# password  	"foobar"
		# password_confirmation  	{ |u| u.password }

		name 		{ Faker::Name.name }
		website 	{ Faker::Internet.url}
		logo_image 	"logo.img"

		# factory :invalid_biz do
		# 	email  " "
		# end

	end
end
