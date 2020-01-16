require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { user.posts.build(text: "Let's say today is a beautiful day") }

  context 'is valid with valid attributes' do
    it 'given a comment as resource' do
      comment = post.comments.build(commentor: user, text: 'I can not agree less')
      like = comment.likes.build(user: user)
      expect(like).to be_valid
      expect(like.likeable_type).to eq 'Comment'
    end

    it 'given a post as resource' do
      like = post.likes.build(user: user)
      expect(like).to be_valid
      expect(like.likeable_type).to eq 'Post'
    end
  end

  context 'is invalid' do
    it 'without a user' do
      comment = post.comments.build(commentor: user, text: 'I can not agree less')
      like = comment.likes.build
      expect(like).to be_invalid
      expect(like.errors.messages[:user]).to include('must exist')
    end

    it 'without a resource' do
      expect { Like.like(user, nil) }.to raise_error(ArgumentError)
    end
  end
end
