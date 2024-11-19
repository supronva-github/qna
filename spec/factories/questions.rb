FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    association :author, factory: :user

    trait :invalid do
      title { nil }
    end

    trait :with_answers do
      transient do
        answers_count { 1 }
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question, author: evaluator.author)
      end
    end
  end
end
