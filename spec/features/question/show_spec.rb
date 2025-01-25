require 'rails_helper'

feature 'User can view question with list of answers', %{
   As a user
   I'd like to be able to view list of answers
} do
  given(:question) { create(:question, :with_answers, answers_count: 2) }

  scenario '' do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)

    question.answers.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end
end
