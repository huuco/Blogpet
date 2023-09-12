class Post < ApplicationRecord
  belongs_to :user
  
  enum status: [:private, :public]

  validates :title, presence: true
  validates :body, presence: true
end
