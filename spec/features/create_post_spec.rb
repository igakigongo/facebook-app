require 'rails_helper'

RSpec.feature 'Post creation' do
  include Devise::Test::IntegrationHelpers

  let(:text) { 'My initial post' }
  let(:messages) { { failure: 'Post was not created', success: 'Post successfully created' } }
  let(:user) { create(:user) }

  before(:each) do
    expect(user).not_to be nil
    sign_in user
    visit root_url
    expect(page).to have_content('edward')
  end

  describe 'succeeds when' do
    it 'performed by an authenticated user and all attributes are valid' do
      fill_in 'create_post_text', with: text

      click_on('Post')
      expect(page).to have_content(messages[:success])
    end
  end

  describe 'fails when' do
    it 'performed by an authenticated user and text is missing' do
      fill_in 'create_post_text', with: ''

      click_on('Post')
      expect(page).to have_content(messages[:failure])
      expect(page).to have_content('You do not have any posts')
    end
  end
end
