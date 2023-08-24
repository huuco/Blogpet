class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

# like/unlike
  after_create_commit do
    broadcast_update_to "product_detail",
    target: "product_#{likeable.id }_like",
    partial: "likes/like",
    locals: { product: likeable, user: user }
  end

  after_destroy_commit do
    broadcast_update_to "product_detail",
    target: "product_#{likeable.id}_like",
    partial: "likes/like",
    locals: { product: likeable, user: user }
  end

# like count
  # after_create_commit do
  #   broadcast_update_to "product_detail",
  #   target: "product_#{likeable.id }_like_count",
  #   partial: "likes/count",
  #   locals: { count: likeable.likes.count }
  # end

  # after_destroy_commit do
  #   broadcast_update_to "product_detail",
  #   target: "product_#{likeable.id}_like_count",
  #   partial: "likes/count",
  #   locals: { count: likeable.likes.count  }
  # end
end
