class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_number, :prefecture_id, :city, :house_number, :building_number, :phone_number

  with_options presence: true do
    validates :postal_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/ }
  end
  validates :prefecture_id numericality: { other_than: 1, message: "選択してください" }

end