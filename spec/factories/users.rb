FactoryBot.define do
  factory :user, class: User do
    date_of_birth { 30.years.ago }
    email { 'igakigongo@gmail.com' }
    first_name { 'edward' }
    gender { 'male' }
    password { 'i-do-not-have-a-password' }
    surname { 'iga' }
  end
end
