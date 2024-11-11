FactoryBot.define do
  factory :order do
    total_amt { 100.0 }
    association :user
  end
end