class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :replies, class_name: Comment.name, foreign_key: :parent_id, dependent: :destroy

  delegate :username, to: :user, prefix: true

  scope :created_at_desc, -> { order(created_at: :desc) }
  scope :root_comments, -> { where(parent_id: nil) }

  def root_comment?
    parent_id.nil?
  end

  def destroy? current_user
    current_user&.id == user_id
  end
end
