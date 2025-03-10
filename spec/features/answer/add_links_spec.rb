require 'rails_helper'

feature 'User can add and deleted links to answer', %q{
  Is order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
  I'd like to be able to delete links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:link) { 'http://link.com' }
  given(:gist_url) { 'https://gist.github.com/supronva-github/bf1d4644eccb10d50a38da6b744fc470' }
  given(:new_link) { 'http://new-link.com' }
  given(:invalid) { 'invalid_url' }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds links when asks answer', js: true do
    within '.new-answer' do
      fill_in 'Body', with: 'Some answer'
      fill_in 'Link name', with: 'My gist'
      fill_in 'URL', with: link
    end

    click_on 'Add link'

    within all('.nested-fields')[1] do
      fill_in 'Link name', with: 'New link'
      fill_in 'URL', with: new_link
    end

    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: link
      expect(page).to have_link 'New link', href: new_link
    end
  end


  scenario 'User add gist link when asks answer', js: true do
    within '.new-answer' do
      fill_in 'Body', with: 'Some answer'
      fill_in 'Link name', with: 'My gist'
      fill_in 'URL', with: gist_url
    end

    click_on 'Add link'
    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_css('li.gist-link')
    end
  end

  scenario 'User remove link at answer', js: true do
    within '.new-answer' do
      click_on 'Remove link'
    end

    expect(page).to_not have_css('.nested-fields')
  end

  scenario 'User cannot add invalid link when posting an answer', js: true do
    within '.new-answer' do
      fill_in 'Body', with: 'Some answer'
      fill_in 'Link name', with: 'My gist'
      fill_in 'URL', with: invalid
    end

    click_on 'Create answer'

    expect(page).not_to have_link('My gist', href: 'invalid')
  end
end
