FactoryBot.define do
  factory :badge do
    name { "Badge" }
    association :winner, factory: :user
    association :question

    trait :with_image do
      after(:create) do |badge|
        file = Rails.root.join('spec', 'fixtures', 'files', 'badge_image.png')
        badge.image.attach(io: File.open(file), filename: 'badge_image.png', content_type: 'image/png')
      end
    end
  end
end
