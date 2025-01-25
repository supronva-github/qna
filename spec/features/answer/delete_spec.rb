require 'rails_helper'

feature 'User can delete his answers', %q{
  As an authorized user
  I can delete my answers to a question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, :with_answers ,answers_count: 1, author: user) }

  scenario 'Author delete answer', js: true do
    sign_in(user)
    visit question_path(question)

    accept_confirm do
      find('a', text: 'Remove answer').click
    end

    expect(page).to_not have_content question.answers.first.body
  end

  scenario 'Non author delete answer' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to have_no_link('Remove answer')
  end
end
