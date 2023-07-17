class Review < ApplicationRecord
  MAX_RATING = 5
  RATING_TITLES = {"0" => "Hated It", "1" => "Didn\'t like it", "2" => "It was okay", "3" => "Liked it", "4" => "Loved it"}
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true
  validates :content, presence: true
  validates :rating, numericality: {in: 0..MAX_RATING}

  scope :order_by_id_desc, ->{ order(id: :desc) }
  scope :order_by_created_at_desc, ->{ order(created_at: :desc) }

  after_create_commit do
    broadcast_prepend_to "product_reviews",
    target: "list_reviews_product_#{product.id}",
    partial: "reviews/review",
    locals: { reviews: product.reviews }
  end
end
