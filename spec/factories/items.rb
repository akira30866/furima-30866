FactoryBot.define do
  factory :item do
    name { "アイテム" }
    description { Faker::Lorem.sentence }
    category_id { "2" }
    condition_id { "2" }
    delivery_charge_id { "2" }
    days_to_ship_id { "2" }
    prefecture_id { "2" }
    price { "5000" }

    association :user

    after(:build) do |img|
      img.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
