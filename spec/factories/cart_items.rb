FactoryBot.define do
  factory :cart_item do
    qty { 1 }
    association :cart
    association :product
  end
end
