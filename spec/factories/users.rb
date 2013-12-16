# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

	factory :user do
		email 		{ Faker::Internet.email }
		password  	"foobarfoobar"
		password_confirmation  	{ |u| u.password }

		factory :invalid_user do
			email  " "
		end

  	end
end
