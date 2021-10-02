FactoryBot.define do
  factory :rating do
    value { rand(0..5) }
    opinion { 'pretty good' }
    sequence(:user_name) { |n| "user_name#{n}" }
    store
  end
end
