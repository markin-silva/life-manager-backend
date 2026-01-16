# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :user
    category { association(:category, user: user) }
    amount { 100.0 }
    currency { "BRL" }
    kind { :income }
    description { "Salary" }
    occurred_at { Time.zone.now }
    paid { true }
  end
end
