FactoryBot.define do
  factory :comment do
    text { 'MyText' }
    user { nil }
    post { nil }
  end
end
