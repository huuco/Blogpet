class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  scope :up, -> { where(vote_flag: true) }
  scope :down, -> { where(vote_flag: false) }

  after_create_commit do
    broadcast_update_to "blog_detail",
    target: "upvote_#{blog.id}",
    partial: "votes/upvote",
    locals: { blog: blog, user: user }
  end

  after_create_commit do
    broadcast_update_to "blog_detail",
    target: "downvote_#{blog.id}",
    partial: "votes/downvote",
    locals: { blog: blog, user: user }
  end

  def voting(vote_flag)
    case vote_flag
    when "upvote"
      self.vote_flag == true ? self.vote_flag = nil : self.vote_flag = true
    when "downvote"
      self.vote_flag == false ? self.vote_flag = nil : self.vote_flag = false
    end
    self.save
  end

end
