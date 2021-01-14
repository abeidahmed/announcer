FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "johndoe#{n}@example.com" }
    full_name { "John Doe" }
    password { "secretpassword" }
    auth_token { "authtoken" }
  end
end
