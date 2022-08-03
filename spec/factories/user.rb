FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    encrypted_password    { password }
    first_name            { '田中' }
    family_name           { '太郎' }
    first_name_kana       { 'タナカ' }
    family_name_kana      { 'タロウ' }
    birth_date            { Faker::Date.birthday }
  end
end
