FactoryBot.define do
  factory :user do
    name                  { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    encrypted_password    {password}
    first_name            { Gimei.last.kanji }
    family_name           { Gimei.first.kanji }
    first_name_kana       { Gimei.last.katakana }
    family_name_kana      { Gimei.first.katakana }
    birth_date            { Faker::Date.birthday }
  end
end