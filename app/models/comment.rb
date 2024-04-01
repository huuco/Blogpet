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

  before_validation :check_before_validation
  after_validation :check_after_validation
  before_save :check_before_save
  around_save :check_around_save
  before_create :check_before_create
  around_create :check_around_create
  after_create :check_after_create
  after_save :check_after_save
  # after_commit/after_rollback

  def check_before_validation
    Rails.logger.info "_________________check_before_validation______________"
  end
  def check_after_validation
    Rails.logger.info "_________________check_after_validation_________________"
  end
  def check_before_save
    Rails.logger.info "_________________check_before_save_________________"
  end
  def check_before_create
    Rails.logger.info "_________________check_before_create_________________"
  end
  def check_around_save
    Rails.logger.info "_________________check_around_save_________________"
  end
  def check_after_create
    Rails.logger.info "_________________check_after_create_________________"
  end
  def check_after_save
    Rails.logger.info "_________________check_after_save_________________"
  end
end
