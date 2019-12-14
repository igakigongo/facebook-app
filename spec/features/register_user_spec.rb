require 'rails_helper'

RSpec.feature 'Successful user registration', type: :feature do
  let(:email) { 'igakigongo@gmail.com' }
  let(:password) { 'some-super-strong-kerberos' }
  let(:success_signup_message) { 'Welcome! You have signed up successfully.' }

  describe 'occurs when' do
    it 'a user fills in all required fields and the email address is not yet taken' do
      visit new_user_registration_path
      fill_in 'First name', with: 'Jubei'
      fill_in 'Surname', with: 'Kibagami'
      fill_in 'Email', with: email
      fill_in 'Date of birth', with: '17/12/1982'
      find('label', text: 'Male').click
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_on('Sign up')

      user = User.find_by('email = ?', email)
      expect(user).not_to be nil
      expect(page).to have_content(success_signup_message)
    end
  end
end

RSpec.feature 'Unsuccessful user registration' do
  context 'occurs when a user' do
    let(:path) { new_user_registration_path }
    let(:fields_with_error_messages) do
      {
        date_of_birth: "Date of birth can't be blank",
        email: "Email can't be blank",
        first_name: "First name can't be blank",
        gender: "Gender can't be blank",
        password: "Password can't be blank",
        surname: "Surname can't be blank"
      }
    end

    it 'does not fill in any of the required fields' do
      fields_with_error_messages.each do |_, message|
        visit path
        click_on('Sign up')
        expect(page).to have_content(message)
      end
    end

    # it 'registers with an existing email address'
  end
end
