FactoryBot.define do
  factory :membership do
    project
    user
    join_date { "2021-01-17 21:09:04" }
    role { "editor" }

    trait :owner do
      role { "owner" }
    end

    trait :pending_owner do
      owner
      join_date { "" }
    end

    trait :pending_editor do
      join_date { "" }
    end
  end
end
