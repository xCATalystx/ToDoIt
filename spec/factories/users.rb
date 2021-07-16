FactoryBot.define do
  factory :user do
    email {'admin@gmail.com'}
    password {'password'}
  end

  trait :other_user do
    email {'user@gmail.com'}
    password {'password'}
  end
end