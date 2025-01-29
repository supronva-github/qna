require 'rails_helper'

feature 'User can delete his files to the answer', %q{
  As an authorized user
  I can delete the file attached to his file.
} do

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:question) { create(:question, author: user) }
  let!(:answer) { create(:answer, :with_files, question: question, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'Author delete files for answer' do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        accept_confirm do
          click_on 'Delete file'
        end
      end

      expect(page).to_not have_link 'rails_helper.rb'
    end

    scenario 'Non author can not delete answer files' do
      sign_in(other_user)
      visit question_path(question)

      within '.answers' do
        expect(page).to have_no_link('Delete file')
      end
    end
  end

  scenario 'Unauthenticated can not delete files for answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link('Delete file')
    end
  end
end
