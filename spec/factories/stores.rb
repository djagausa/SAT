# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    factory :store do
        association   :biz
        street1             { Faker::Address.street_address }
        street2             { Faker::Address.secondary_address }
        city                { Faker::Address.city }
        state               { Faker::Address.state_abbr }
        zip_code            { Faker::Address.zip }
        phone_number        { Faker::PhoneNumber.phone_number }
        contact_name        { Faker::Name.name }
        hours               "3-5"
        days                "m-s"

        factory :invalid_store do
            zip_code ""
        end
    end
end
