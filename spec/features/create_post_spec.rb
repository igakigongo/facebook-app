require 'rails_helper'

RSpec.feature 'Successful post creation' do
  include Devise::Test::IntegrationHelpers
  
  let(:text) { 'My initial post' }
  let(:user) { create(:user) }

  describe 'occurs when' do
    it 'performed by an authenticated user and all attributes are valid' do
      # sign in the user
      # fill in the post form on the page
      # assert that it was created
      # check if the view contains ---
      expect(user).not_to be nil
      sign_in user

      # get the current controller 
      # expect(current_user).not_to be nil
      # expect(page).to contain('edward')



      # sign_in 'user'
      # visit some_link
      # delay time = 'session timeout'
      # visit another link
      # expect (url === sign_in url)
    end
  end
end