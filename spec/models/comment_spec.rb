require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }

  it 'is valid with all attributes filled in' do
    post = user.posts.build(text: "Assume any post, it can be attached to some other user")
    comment = post.comments.build(text: 'I like this kind of stuff', user_id: user.id)
    expect(comment).to be_valid
  end
  
  context 'is invalid' do
    let(:comment) { Comment.new }

    it 'when text is null' do
      expect(comment).to be_invalid
      expect(comment.errors.messages[:text]).to include("can't be blank")
    end

    it 'when text is empty or white space' do
      blank_text = ' ' * 50
      comment = Comment.new(text: blank_text)
      expect(comment).to be_invalid
      expect(comment.errors.messages[:text]).to include("can't be blank")
    end

    it 'without an associated user/commentor' do
      expect(comment).to be_invalid
      expect(comment.errors.messages[:commentor]).to include("must exist")
    end

    it 'without an associated post' do
      expect(comment).to be_invalid
      expect(comment.errors.messages[:post]).to include("must exist")
    end
  end
end
