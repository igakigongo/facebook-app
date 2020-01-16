class Post < ApplicationRecord
  # associations
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy

  # validations
  validates :text, presence: true, allow_blank: false
end
