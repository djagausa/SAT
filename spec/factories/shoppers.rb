# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

	factory :shopper do
		# email 		{ Faker::Internet.email }
		# password  	"foobar"
		# password_confirmation  	{ |u| u.password }

		zip_code 	{ Faker::Address.zip }
		distance 	{ Faker::Number.number(3) }
		home_page 	true
	end

	# factory :invalid_shopper do
	# 	email  " "
	# end
end