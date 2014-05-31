FactoryGirl.define do
  factory :user do
    email 'dan@me.me'
    password '12345678'
    password_confirmation '12345678'
  end
end