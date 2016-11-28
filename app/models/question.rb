class Question < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :answers
  has_many :comments, as: :content
  has_many :votes, as: :target

  validates :title, :description, :user_id, { presence: true }
  validate :valid_title

  def valid_title
    if self.title.length > 99
      return errors.add :question, "title must be under 100 characters in length"
    end
  end

  def vote_count
    votes = self.votes.to_a.map!{|vote| vote.value }.reduce(:+)
    if votes == nil
      return 0
    else
      return votes
    end
  end

  # return true if user already answered this question before
  def answered_by?(user_id)
    target_user = User.find_by_id(user_id)
    answerers = self.answers.map { |answer| answer.user }
    answerers.include?(target_user)
  end

  # return the best answer if exists, nil otherwise
  def best_answer
    self.answers.find { |answer| answer.best_answer == 1 }
  end

  def answered?
    !!(best_answer)
  end

  def upvoted_by?(user_id)
    !!(self.votes.find { |vote| vote.user_id == user_id && vote.value == 1 })
  end

  def downvoted_by?(user_id)
    !!(self.votes.find { |vote| vote.user_id == user_id && vote.value == -1 })
  end
end
