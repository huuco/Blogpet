class Product < ApplicationRecord
  ACTION_ADD = "add"
  ACTION_REMOVE = "remove"

  has_many_attached :images

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
