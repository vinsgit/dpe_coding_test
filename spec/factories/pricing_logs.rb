FactoryBot.define do
  factory :pricing_log do
    previous_price { 100 }
    new_price { 120 }
    reason { "Price adjustment" }
    association :product
  end
end