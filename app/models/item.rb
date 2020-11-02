class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::AcitveRecordExtensions
  belongs_to :category
end
