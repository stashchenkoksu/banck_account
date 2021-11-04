# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user = Faker::Name

    first_name { user.first_name }
    middle_name { user.middle_name }
    last_name { user.last_name }
    identify_number { Faker::DrivingLicence.british_driving_licence }

    trait :with_tags do
      before(:create) do |user|
        create_list(:tag, 2, users: [user])
        create_list(:account, 2, user: user)

        user.reload
      end
    end
  end
end
