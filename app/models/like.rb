class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  def self.dislike(user, resource_type)
    like = resource_type.likes.find_by(user: user)
    like.destroy
  end

  def self.like(user, resource_type)
    resource_type.likes.create(user: user)
  end
end
