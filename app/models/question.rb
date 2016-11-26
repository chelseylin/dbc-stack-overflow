class Question < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :answers
  has_many :comments, as: :content
  has_many :votes, as: :target

  validates :title, :description, :user_id, { presence: true }

  def vote_count
    votes = self.votes.to_a.map!{|vote| vote.value }.reduce(:+)
    if votes == nil
      return 0
    else
      return votes
    end
  end
end
