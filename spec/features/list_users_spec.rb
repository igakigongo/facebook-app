require 'rails_helper'

RSpec.feature 'List Users', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  it 'shows an alert if the system has only the currently logged in user' do
    visit users_index_url
    expect(page).to have_content('No other users on the system except you')
  end

  it 'displays another user\'s name if they exist in the system' do
    other_user = User.create(date_of_birth: 20.years.ago, first_name: 'robert', surname: 'wasswa',
                             gender: 'male', email: 'wasswa.robert@gmail.com', password: 'rokuren')
    visit users_index_url
    expect(other_user).to be_valid
    expect(page).to have_content(other_user.full_name)
  end
end
