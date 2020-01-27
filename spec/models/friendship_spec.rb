require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create(:user) }

  it 'must have a principal -> user/initiator' do
    friendship = Friendship.new
    expect(friendship).to be_invalid
    expect(friendship.errors.messages[:user]).to eq(['must exist', "can't be blank"])
  end

  it 'must have a dependent -> friend/target' do
    friendship = Friendship.new
    expect(friendship).to be_invalid
    expect(friendship.errors.messages[:friend]).to eq(['must exist', "can't be blank"])
  end

  it 'raises an error if a person attempt to add him/her self as a friend' do
    friendship = Friendship.create(friend: user, user: user)
    expect(friendship).to be_invalid
    expect(friendship.errors.messages[:friendship_is_reflexive]).to eq(['you can not be a friend to yourself'])
  end
end
