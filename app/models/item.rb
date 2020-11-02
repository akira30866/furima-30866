class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::AcitveRecordExtensions
  belongs_to :category
  belongs_to :conditon
  belongs_to :delivery_charge

  # ActiveHashのバリデーションに注意

end
