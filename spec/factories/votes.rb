FactoryBot.define do
  factory :vote do
    association :user
    value { 1 }
    association :votable, factory: :question
  end
end
