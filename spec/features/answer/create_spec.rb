require 'rails_helper'

feature 'User can create answers to the question', %q{
  As a user
  I would like to be able to create answers to a question
} do

  given(:question) { create(:question, author: user) }
  given(:user) { create(:user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'when answer created successfully' do
      fill_in 'Body', with: 'Some answer'
      click_on 'Create answer'

      expect(page).to have_content 'Some answer'
    end

    scenario 'when answer created unsuccessfully' do
      click_on 'Create answer'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'ask a answer whith attached file' do
      fill_in 'Body', with: 'text text'
      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Create answer'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'An unauthenticated user is trying to answer a question' do
    visit question_path(question)
    click_on 'Create answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
