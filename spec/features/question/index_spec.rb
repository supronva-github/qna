require 'rails_helper'

feature 'User can view list of question', %q{
  As a user
  I want to view the list of questions
} do

  given!(:questions) { create_list(:question, 3) }

  scenario 'The user sees all questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end
