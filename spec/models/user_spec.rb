require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  context 'before save' do
    let(:email) { 'MALCOMEDDIE@HOTMAIL.COM' }
    let(:user) { build(:user, email: email) }
    it 'has their email transformed to lowercase' do
      user.save
      expect(user.email).to eq email.downcase
    end

    it 'gets an image_url generated from their email address' do
      user.save
      expect(user.image_url).to be
    end
  end

  context 'is invalid' do
    let(:user) { User.new }
    let(:validation_message) { ["can't be blank"] }

    before do
      expect(user).to be_invalid
    end

    it 'without a date of birth' do
      expect(user.errors.messages[:date_of_birth]).to eq validation_message
    end

    it 'without an email address' do
      expect(user.errors.messages[:email]).to eq ["can't be blank"]
    end

    it 'without a first name' do
      expect(user.errors.messages[:first_name]).to eq ["can't be blank"]
    end

    it 'without a gender' do
      expect(user.errors.messages[:gender]).to eq ["can't be blank"]
    end

    it 'without a password' do
      expect(user.errors.messages[:password]).to eq ["can't be blank"]
    end

    it 'without a surname' do
      expect(user.errors.messages[:surname]).to eq ["can't be blank"]
    end
  end
end
