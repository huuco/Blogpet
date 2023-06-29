class Product < ApplicationRecord
  has_many_attached :images

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
