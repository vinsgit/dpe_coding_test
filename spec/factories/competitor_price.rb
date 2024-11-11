# spec/factories/competitor_prices.rb
FactoryBot.define do
  factory :competitor_price do
    price { 100 }
    competitor_name { "fly" }
    association :product
  end
end