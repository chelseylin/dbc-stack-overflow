class Comment < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user # the user who made the comment
  belongs_to :content, polymorphic: true # the category & id the comment belongs to
  has_many :votes, as: :target # the votes for the comment

  validates :description, :user_id, :content_type, :content_id, { presence: true }

  def vote_count
    votes = self.votes.to_a.map!{|vote| vote.value }.reduce(:+)
    if votes == nil
      return 0
    else
      return votes
    end
  end
  
end
