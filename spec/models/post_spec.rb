require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    post = user.posts.build(text: "Let's say today is a beautiful day")
    expect(post).to be_valid
  end

  context 'is invalid' do
    let(:post) { Post.new }

    it 'when text is blank' do
      blank_text = ' ' * 50
      post = user.posts.build(text: blank_text)
      expect(post).to be_invalid
      expect(post.errors.messages[:text]).to include("can't be blank")
    end

    it 'without a user id' do
      expect(post).to be_invalid
      expect(post.errors.messages[:creator]).to include('must exist')
    end

    it 'without text' do
      post = user.posts.build(text: '')
      expect(post).to be_invalid
      expect(post.errors.messages[:text]).to include("can't be blank")
    end
  end
end
