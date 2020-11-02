class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :days_to_ship
  belongs_to :prefecture

  # ActiveHashのバリデーションに注意
  VALID_PRICE_REGEX = /\A[0-9]+\z/

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :category
    validates :condition
    validates :delivery_charge
    validates :prefecture
    validates :days_to_ship
    validates :price, format: { with: VALID_PRICE_REGEX }, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 1, message: "選択してください" } do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :days_to_ship_id
    validates :prefecture_id
  end
end
