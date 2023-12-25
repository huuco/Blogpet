class Blog < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  delegate :username, to: :user

  def downvote
    votes.down.count
  end

  def upvote
    votes.up.count
  end
end
