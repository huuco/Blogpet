class Order < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  belongs_to :shipping
  has_many :order_details, dependent: :destroy
end
