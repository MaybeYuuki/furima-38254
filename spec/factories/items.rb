FactoryBot.define do
  factory :item do
    name { Faker::Name.initials(number: 2) }
    explanation { Faker::Lorem.characters(16) }
    category_id { Faker::Number.within(range: 1..10) }
    postage_id { Faker::Number.within(range: 1..2) }
    status_id { Faker::Number.within(range: 1..6) }
    area_id { Faker::Number.within(range: 1..47) }
    days_id { Faker::Number.within(range: 1..3) }
    price { Faker::Number.within(range: 300..9_999_999) }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/sample1.jpg'), filename: 'sample1.jpg')
    end
  end
end
