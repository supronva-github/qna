require 'rails_helper'

feature 'User can add links to question', %q{
  Is order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/supronva-github/bf1d4644eccb10d50a38da6b744fc470' }

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'
    fill_in 'Link name', with: 'My gist'
    fill_in 'URL', with: gist_url
    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
  end
end
