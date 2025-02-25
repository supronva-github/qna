require 'rails_helper'

feature 'User can sign out', %q{
  In order to protect my account
  As an authenticated user
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'successfully signs out' do
    sign_in(user)
    click_on('Log out')

    expect(page).to have_content 'Signed out successfully.'
  end
end
