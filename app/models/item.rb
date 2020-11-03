class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :days_to_ship
  belongs_to_active_hash :prefecture

  # ActiveHashのバリデーションに注意
  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :category
    validates :condition
    validates :delivery_charge
    validates :prefecture
    validates :days_to_ship
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 1, message: "選択してください" } do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :days_to_ship_id
    validates :prefecture_id
  end
end
