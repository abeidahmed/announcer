FactoryBot.define do
  factory :project do
    name { "Applog space" }
    sequence(:subdomain) { |n| "applogspace#{n}" }
    plan_type { "free" }

    trait :premium do
      plan_type { "premium" }
    end
  end
end
