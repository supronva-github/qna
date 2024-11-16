FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "Mytext#{n}" }
    association :question

    trait :invalid do
      body { nil }
    end
  end
end
