require 'rails_helper'

feature 'User can add links to answer', %q{
  Is order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:gist_url) { 'https://gist.github.com/supronva-github/bf1d4644eccb10d50a38da6b744fc470' }

  scenario 'User adds link when asks answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.new-answer' do
      fill_in 'Body', with: 'Some answer'
      fill_in 'Link name', with: 'My gist'
      fill_in 'URL', with: gist_url

      click_on 'Create answer'
    end

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end
end
