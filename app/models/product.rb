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
    likes.pluck(:user_id).include?(user.id)
  end

  def like(user)
    !liked?(user) && likes << Like.new(user: user)
  end

  def unlike(user)
    liked?(user) && likes.find_by(user: user).destroy
  end


  def star_count
    @star_count ||= reviews.pluck(:rating).sort
  end

  def total_star
    star_count.size
  end

  def star
    return [0] if star_count.empty?
    [
      (star_count.count(1)/total_star)*100,
      (star_count.count(2)/total_star)*100,
      (star_count.count(3)/total_star)*100,
      (star_count.count(4)/total_star)*100,
      (star_count.count(5)/total_star)*100
    ]
  end

  def coverage_star
    return 0 if star_count.empty?
    star_count.sum*1.0 / total_star
  end
end
