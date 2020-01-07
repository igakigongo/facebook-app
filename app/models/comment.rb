class Comment < ApplicationRecord
  # associations
  belongs_to :commentor, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  # validations
  validates :text, presence: true, allow_blank: false
end
