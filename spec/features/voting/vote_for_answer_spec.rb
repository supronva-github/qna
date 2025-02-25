require 'rails_helper'

feature 'Vote for answer', %q{
  In order to vote for answer
  An an user
  I'd like to vote for answer
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  describe 'Non-author', js: true do
	  before do
	    sign_in(other_user)
	    visit question_path(question)
	  end

	  scenario 'Can like or dislike' do
      expect(page).to have_css('a[aria-label="Like"]')
      expect(page).to have_css('a[aria-label="Dislike"]')
    end
	end

  scenario 'Author can not vote', js: true do
    sign_in(user)
    visit question_path(question)
		within '.answers' do
      expect(page).to have_no_css('a[aria-label="Like"]')
      expect(page).to have_no_css('a[aria-label="Dislike"]')
    end
  end

  scenario 'Non-authenticated user can not vote', js: true do
  	visit question_path(question)
    expect(page).to have_no_css('a[aria-label="Like"]')
    expect(page).to have_no_css('a[aria-label="Dislike"]')
  end
end
