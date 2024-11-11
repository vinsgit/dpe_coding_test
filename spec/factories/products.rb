FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    qty { rand(1..100) }
    default_price { rand(10.0..100.0) }
    dynamic_price { nil }
    association :category
  end
end
