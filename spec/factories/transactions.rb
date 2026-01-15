# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :user
    amount { 100.0 }
    kind { :income }
    description { "Salary" }
    category { "Job" }
    occurred_at { Time.zone.now }
  end
end
