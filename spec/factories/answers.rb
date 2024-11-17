FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "Mytext#{n}" }
    association :question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
