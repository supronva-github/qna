require 'rails_helper'

feature 'User can delete question',%q{
  As a user
  I can delete my question
  } do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, author: user) }

  scenario 'When I delete my question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'

    expect(page).to have_content 'Question successfully deleted.'
  end
end
