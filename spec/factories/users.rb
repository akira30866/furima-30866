FactoryBot.define do
  factory :user do
    nickname               { Faker::Name.initials(number: 2) }
    email                  { Faker::Internet.email }
    password = Faker::Internet.password(min_length:6) 
    password               { password }
    password_confirmation  { password }
    family_name            { "山田" }
    first_name             { "太郎" }
    family_name_kana       { "ヤマダ" }
    first_name_kana        { "タロウ" }
    birthday               { Faker::Date.birthday }
  end
end
