class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :replies, class_name: Comment.name, foreign_key: :parent_id, dependent: :destroy

  delegate :username, to: :user, prefix: true

  scope :created_at_desc, -> {order(created_at: :desc)}
  scope :children, -> {where(parent: nil)}

  after_create_commit do
    broadcast_update_to "blog_detail",
    target: "comments_blog_#{commentable.id}",
    partial: "comments/widget",
    locals: { commentable: commentable }
  end
end
