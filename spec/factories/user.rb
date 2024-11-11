FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    password { "password" }

    trait :admin do
      username { User::ADMIN_NAME }
    end
  end
end
