FactoryBot.define do
  factory :cart do
    status { :ongoing }
    association :user
  end
end
