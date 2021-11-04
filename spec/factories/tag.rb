# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:title) { |n| "#{Faker::Color.color_name}_#{n}" }
  end
end
