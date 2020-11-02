class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :conditon
  belongs_to :delivery_charge
  belongs_to :days_to_ship
  belongs_to :prefecture

  # ActiveHashのバリデーションに注意
  VALID_PRICE_REGEX = /\A[0-9]+\z/i

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :category
    validates :conditon
    validates :delivery_charge
    validates :prefecture
    validates :days_to_ship
    validates :price, format: { with: VALID_PRICE_REGEX, message: "半角数字で入力してください" }, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :conditon_id
    validates :delivery_charge_id
    validates :days_to_ship_id
    validates :prefecture_id
  end
end
