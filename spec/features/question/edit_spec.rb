require 'rails_helper'

feature 'User can edit his question', %q{
  In order to correct mistakes
  As the author of the question
  I would like to be able to edit my question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given(:other_user) { create(:user) }

  scenario 'Unauthenticated can not edit question' do
    visit question_path(question)

    expect(page).to have_no_link 'Edit question'
  end

  describe 'Authenticated user', js: true do
    context 'edits his question' do
      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'successfully edits question' do
        within '.question' do
          click_on 'Edit question'
          fill_in 'Title', with: 'new title question'
          fill_in 'Body', with: 'new body question'
          click_on 'Save'

          expect(page).to_not have_content question.title
          expect(page).to_not have_content question.body
          expect(page).to have_content 'new title question'
          expect(page).to have_content 'new body question'
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'successfully edits question with attach files' do
        within '.question' do
          click_on 'Edit question'
          fill_in 'Title', with: 'new title question'
          fill_in 'Body', with: 'new body question'

          attach_file 'Files', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb').to_s}"]
          click_on 'Save'

          expect(page).to_not have_content question.title
          expect(page).to_not have_content question.body
          expect(page).to have_content 'new title question'
          expect(page).to have_content 'new body question'
          expect(page).to_not have_selector 'textarea'
          expect(page).to have_link 'spec_helper.rb'
          expect(page).to have_link 'rails_helper.rb'
        end
      end

      scenario 'not successful' do
        within '.question' do
          click_on 'Edit question'
          fill_in 'Title', with: ''
          fill_in 'Body', with: ''
          click_on 'Save'
        end

         within '.question-errors' do
          expect(page).to have_content "Body can't be blank"
        end
      end
    end

     scenario "tries to edit other user's question" do
      sign_in(other_user)
      visit question_path(question)

      within '.question' do
        expect(page).to have_no_link 'Edit question'
      end
     end
  end
end
