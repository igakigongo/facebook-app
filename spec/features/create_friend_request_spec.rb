require 'rails_helper'

RSpec.feature 'Send Friend Request' do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  it 'succeeds if we are not already friends' do
    Friendship.create(friend: other_user, user: user)

    sign_in user
    visit users_index_url
    expect(page).to have_content(other_user.full_name)
  end
end
