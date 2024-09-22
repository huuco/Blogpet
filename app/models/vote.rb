class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  scope :up, -> { where(vote_flag: true) }
  scope :down, -> { where(vote_flag: false) }

  def voting(vote_flag)
    self.vote_flag = case vote_flag
                     when "upvote"
                       self.vote_flag == true ? nil : true
                     when "downvote"
                       self.vote_flag == false ? nil : false
                     else
                       self.vote_flag
                     end
    save
  end

end
