class Product < ApplicationRecord
  ACTION_ADD = "add"
  ACTION_REMOVE = "remove"

  has_many_attached :images
  has_many :likes, as: :likeable
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  def liked?(user)
    likes.find_by(user: user).present?
  end

  def like(user)
    likes << Like.new(user: user) unless liked?(user)
  end

  def unlike(user)
    likes.find_by(user: user).destroy if liked?(user)
  end


  def star_count
    @star_count ||= reviews.pluck(:rating).sort
  end

  def total_star
    star_count.size
  end

  def star
    return [0] if star_count.empty?
    total = star_count.size.to_f
    (1..5).map { |rating| (star_count.count(rating) / total * 100).round(2) }
  end

  def coverage_star
    return 0 if star_count.empty?
    star_count.sum.to_f / star_count.size
  end
end
