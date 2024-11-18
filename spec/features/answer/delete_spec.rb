require 'rails_helper'

feature 'User can delete his answers', %q{
  As an authorized user
  I can delete my answers to a question
} do

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:question) { create(:question, answers_count: 2, author: user) }

  scenario 'Author delete answer' do
    sign_in(user)
    visit question_path(question)
    first('a', text: 'Remove answer').click

    expect(page).to have_content 'Answer successfully deleted.'
  end

  scenario 'Non author delete answer' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to have_no_link('Remove answer')
  end
end
