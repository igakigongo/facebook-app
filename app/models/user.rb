require 'digest/md5'

class User < ApplicationRecord
  # devise modules
  # :omniauthable
  # :confirmable,
  devise :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  # associations
  has_many :posts

  # callbacks
  before_save :transform_email, :create_image_url

  # validations
  validates :date_of_birth, presence: true
  validates :first_name, presence: true
  validates :gender, presence: true
  validates :surname, presence: true

  # helpers

  protected

  def create_image_url
    hash = Digest::MD5.hexdigest(email)
    self.image_url = "https://www.gravatar.com/avatar/#{hash}"
  end

  def transform_email
    self.email = email.downcase
  end
end
