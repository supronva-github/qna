require 'rails_helper'

feature 'User can view their badges', %{
   As a user
   I'd like to be able to view my badges
} do
  given(:user) { create(:user) }
  given!(:badge) { create(:badge, :with_image, winner: user) }

  context 'When the user is logged in' do
    background do
      sign_in(user)
      visit badges_path
    end

    scenario 'User sees the bages' do
      expect(page).to have_content(badge.question.title)
      expect(page).to have_css("img[src*='badge_image.png']")
    end
  end

  context 'When the user is not logged in' do
    scenario 'User sees no badges' do
      visit badges_path
      expect(page).not_to have_content(badge.question.title)
      expect(page).not_to have_css("img[src*='badge_image.png']")
    end
  end
end
