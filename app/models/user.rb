require 'digest/md5'

class User < ApplicationRecord
  # devise modules
  # :omniauthable
  # :confirmable,
  devise :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  # associations
  has_many :likes, dependent: :destroy
  has_many :posts
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # callbacks
  before_save :transform_email, :create_image_url

  # validations
  validates :date_of_birth, presence: true
  validates :first_name, presence: true
  validates :gender, presence: true
  validates :surname, presence: true

  # helpers
  def full_name
    "#{first_name} #{surname}"
  end

  def friend_with?(other_user)
    Friendship.confirmed.where(user: self).where(friend: other_user).exists?
  end

  def pending_friend_request_to?(other_user)
    Friendship.pending_requests.where(user: self).where(friend: other_user).exists?
  end

  def pending_friend_request_from?(other_user)
    Friendship.pending_requests.where(user: other_user).where(friend: self).exists?
  end

  def pending_friend_requests
    0
    # Friendship.pending_requests.where(user: self).count()
  end

  protected

  def create_image_url
    hash = Digest::MD5.hexdigest(email)
    self.image_url = "https://www.gravatar.com/avatar/#{hash}"
  end

  def transform_email
    self.email = email.downcase
  end
end
