class Product < ApplicationRecord
  ACTION_ADD = "add"
  ACTION_REMOVE = "remove"

  has_many_attached :images
  has_many :likes, as: :likeable

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
end
