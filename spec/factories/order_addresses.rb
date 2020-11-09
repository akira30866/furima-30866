FactoryBot.define do
  factory :order_address do
    postal_number   { '123-4567' }
    prefecture_id   { 2 }
    city            { '横浜' }
    house_number    { '青山' }
    building_number { '柳ビル' }
    phone_number    { '00012345678' }
    token           { "tok_abcdefghijk00000000000000000" }
  end
end
