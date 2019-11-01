class User < ApplicationRecord
  # devise modules
  # :omniauthable
  devise :confirmable, :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  # validations
  validates :date_of_birth, presence: true
  validates :first_name, presence: true
  validates :gender, presence: true
  validates :surname, presence: true
end
