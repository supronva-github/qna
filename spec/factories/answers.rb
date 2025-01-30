FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "Mytext#{n}" }
    association :question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end

    trait :with_files do
      files { [Rack::Test::UploadedFile.new(Rails.root.join('spec/rails_helper.rb'))] }
    end
  end
end
