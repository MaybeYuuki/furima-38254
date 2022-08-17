FactoryBot.define do
  factory :purchase_address do
    token { 'eovnieonvievsa' }
    postal_code { '123-4567' }
    area_id { 1 }
    municipalities { '札幌市西区' }
    address { '青山1条1丁目' }
    phone_number { '10000000000' }
    association :item
    association :user
  end
end
