class Friendship < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # scopes
  scope :confirmed, -> { where(confirmed: true) }
  scope :pending_requests, -> { where(confirmed: false) }

  # validations
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :reflexiveness

  # confirm a relationship
  # create the other relation (friend as me -> user as other)
  def confirm
    transaction do
      update(confirmed: true)
      Friendship.create(confirmed: true, friend: user, user: friend)
    end
  end

  # end a relationship
  # destroy both relations [(friend, user), (user, friend)]
  def terminate
    transaction do
      destroy
      @other = Friendship.find_by(friend: user, user: friend)
      @other&.destroy
    end
  end

  # helper methods
  def self.confirmed_friends_for(user)
    confirmed.where(user: user).map(&:friend)
  end

  private

  # validate self referencing
  def reflexiveness
    errors.add(:friendship_is_reflexive, 'you can not be a friend to yourself') if user == friend
  end
end
