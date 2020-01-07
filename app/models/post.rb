class Post < ApplicationRecord
  # associations
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments

  # validations
  validates :text, presence: true, allow_blank: false
end
