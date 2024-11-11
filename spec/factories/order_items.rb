FactoryBot.define do
  factory :order_item do
    qty { 1 }
    association :order
    association :product
  end
end
