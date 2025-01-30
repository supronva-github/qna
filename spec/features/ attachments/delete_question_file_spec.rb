require 'rails_helper'

feature 'User can delete his files to the question', %q{
  As an authorized user
  I can delete the file attached to his file.
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, :with_files, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'Author delete files for answer' do
      sign_in(user)
      visit question_path(question)

      accept_confirm do
        click_on 'Delete file'
      end

      expect(page).to_not have_link 'rails_helper.rb'
    end

    scenario 'Non author can not delete question files' do
      sign_in(other_user)
      visit question_path(question)

      expect(page).to have_no_link('Delete file')
    end
  end

  scenario 'Unauthenticated can not delete files for answer' do
    visit question_path(question)

    expect(page).to have_no_link('Delete file')
  end
end
