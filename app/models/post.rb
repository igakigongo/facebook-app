class Post < ApplicationRecord
  # associations
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy

  # helper methods
  def self.for_users_timeline(user)
      where(user_id: user)
      .or(where(user_id: Friendship.confirmed_friends_for(user)))
      .includes(:creator).order(updated_at: :desc)
      .includes(comments: [:commentor])
      .includes(:likes)
  end

  # validations
  validates :text, presence: true, allow_blank: false
end
