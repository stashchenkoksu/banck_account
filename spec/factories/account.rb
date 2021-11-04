# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    CURRENCY = %i[USD EUR RUB BYR YEN UAN].freeze
    amount { Faker::Number.decimal }
    currency { CURRENCY.sample }

    association :user, factory: :user
  end
end
