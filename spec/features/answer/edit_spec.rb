require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, :with_answers, author: user) }
  given(:other_user) { create(:user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    context 'edits his answer' do
      background do
        sign_in(user)
        visit question_path(question)
        click_on 'Edit'
      end

      scenario 'successfully' do
        within '.answers' do
          fill_in 'You answer', with: 'edited answer'

          click_on 'Save'

          expect(page).to_not have_content question.answers.first.body
          expect(page).to have_content 'edited answer'
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'not successful' do
        within '.answers' do
          fill_in 'You answer', with: ''
          click_on 'Save'
        end

        within '.answers-erros' do
          expect(page).to have_content "Body can't be blank"
        end
      end
    end

    scenario "tries to edit other user's answer" do
      sign_in(other_user)
      visit question_path(question)

      expect(page).to have_no_link 'Edit'
    end
  end
end
