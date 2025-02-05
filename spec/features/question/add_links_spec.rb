require 'rails_helper'

feature 'User can add adn delete links to question', %q{
  Is order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
  I'd like to be able to delete links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/supronva-github/bf1d4644eccb10d50a38da6b744fc470' }
  given(:new_link) { 'http://new-link.com' }
  given(:invalid) { 'invalid_url' }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds links when asks question', js: true do
    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'
    fill_in 'Link name', with: 'My gist'
    fill_in 'URL', with: gist_url

    click_on 'Add link'

    within all('.nested-fields')[1] do
      fill_in 'Link name', with: 'New link'
      fill_in 'URL', with: new_link
    end

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
    expect(page).to have_link 'New link', href: new_link
  end

  scenario 'User remove link at question', js: true do
    click_on 'Remove link'

    expect(page).to_not have_css('.nested-fields')
  end

  scenario 'User cannot add invalid link when posting an question', js: true do
    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'
    fill_in 'Link name', with: 'My gist'
    fill_in 'URL', with: invalid

    click_on 'Ask'

    expect(page).not_to have_link('My gist', href: 'invalid')
  end
end
