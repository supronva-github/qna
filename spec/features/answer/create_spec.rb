require 'rails_helper'

feature 'User can create answers to the question', %q{
  As a user
  I would like to be able to create answers to a question
} do

  given(:question) { create(:question) }

  background do
    visit question_path(question)

  end

  scenario '' do
    fill_in 'Body', with: 'Some answer'
    click_on 'Create answer'
    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'Some answer'
  end

  scenario '' do
    click_on 'Create answer'
    expect(page).to have_content "Body can't be blank"
  end
end
