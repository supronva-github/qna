FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    association :author, factory: :user

    transient do
      answers_count { 0 }
    end

    after(:create) do |question, evaluator|
      create_list(:answer, evaluator.answers_count, question: question)
    end

    trait :invalid do
      title { nil }
    end
  end
end
