FactoryGirl.define do
  factory :post do
    title "Partay!"
    description "I don't know any of these people!"
    picture { fixture_file_upload(Rails.root.join('spec', 'images', 'tinytest.png'), 'image/png') }
  end
end