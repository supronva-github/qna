FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    association :author, factory: :user

    trait :invalid do
      title { nil }
    end

    after(:create) do |question|
      create(:badge, question: question)
    end

    trait :with_answers do
      transient do
        answers_count { 1 }
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question, author: evaluator.author)
      end
    end

    trait :with_files do
      files { [Rack::Test::UploadedFile.new(Rails.root.join('spec/rails_helper.rb'))] }
    end
  end
end
