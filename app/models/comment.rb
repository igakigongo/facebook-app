class Comment < ApplicationRecord
  # associations
  belongs_to :commentor, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  # validations
  validates :text, presence: true, allow_blank: false
end
