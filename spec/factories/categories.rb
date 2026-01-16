# frozen_string_literal: true

FactoryBot.define do
  sequence(:system_key) { |n| "system_#{n}" }

  factory :category do
    association :user
    name { "Custom" }
    color { "#FFAA00" }
    icon { "tag" }
    system { false }

    trait :system do
      user { nil }
      key { generate(:system_key) }
      name { nil }
      color { "#FF6B6B" }
      icon { "utensils" }
      system { true }
    end
  end
end
