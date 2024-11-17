require 'rails_helper'

feature 'User can sign up', %q{
  As a user
  I want to register in the service to use its functionality
} do
  given!(:user) { create(:user) }
  given(:password) { '12345678' }
  given(:invalid_password_confirmation) { '12345679' }
  given(:short_password) { '123'}
  given(:email) { 'new_mail@domain.com'}

  background { visit new_user_registration_path }
  scenario 'Successful registration' do
    sign_up(email: email, password: password, password_confirmation: password)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  describe 'Unsuccessful registration' do
    scenario 'When the entered passwords do not match' do
      sign_up(email: email, password: password, password_confirmation: invalid_password_confirmation)

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'When email is already in use' do
      sign_up(email: user.email, password: password, password_confirmation: password)

      expect(page).to have_content 'Email has already been taken'
    end

    scenario 'When the registration form is not completed' do
      sign_up(email: '', password: '', password_confirmation: '')

      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
    end

    scenario 'When a password fails validation' do
      sign_up(email: user.email, password: short_password, password_confirmation: short_password)

      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end
  end
end
