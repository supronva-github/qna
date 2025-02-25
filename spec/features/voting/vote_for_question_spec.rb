require 'rails_helper'

feature 'Vote for question', %q{
  An an user
  I'd like to vote for question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Non-author', js: true  do
	  before do
	    sign_in(other_user)
	    visit question_path(question)
	  end

	  scenario 'Can like' do
      find('a[aria-label="Like"]').click
	    expect(page).to have_content 'Rating: 1'
	  end

	  scenario 'Can dislike', js: true do
      find('a[aria-label="Dislike"]').click
	    expect(page).to have_content 'Rating: -1'
	  end
	end

  scenario 'Author can not vote', js: true do
    sign_in(user)
    visit question_path(question)
		within '.question' do
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
