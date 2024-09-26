class Blog < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments,as: :commentable, dependent: :destroy, counter_cache: true
  delegate :username, to: :user

  def downvote
    votes.down.count
  end

  def upvote
    votes.up.count
  end
end
