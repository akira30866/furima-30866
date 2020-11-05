class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_number, :prefecture_id, :city, :house_number, :building_number, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/ }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "選択してください" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_number: postal_number, prefecture_id: prefecture_id, city: city, house_number: house_number, building_number: building_number, phone_number: phone_number, order_id: order.id)
  end
end