require 'rails_helper'

feature 'User can choose the best answer', %q{
  As an authorized user
  I can choose the best answer for my question
  I can choose another answer as the best answer if the question already has the best answer selected
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, :with_answers ,answers_count: 1, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'The author of the question can choose the best answer' do
      sign_in(user)
      visit question_path(question)
      click_on 'Best'

      answer = question.answers.first
      expect(page).to have_css("tr#answer-#{answer.id}.best")
      expect(page).to have_no_css("tr#answer-#{answer.id} .mark-as-best-btn")
    end

    scenario 'The user is not the author and cannot select the best answer' do
      sign_in(other_user)
      visit question_path(question)

      expect(page).to have_no_button('Best')
    end
  end

  scenario 'An unauthorized user does not see the best answer button', js: true do
    visit question_path(question)

    expect(page).to have_no_button('Best')
  end
end
