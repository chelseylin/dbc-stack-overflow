class Answer < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user # the user created the answer
  belongs_to :question # the question the answer belongs to
  has_many :comments, as: :content # the comments for the answer
  has_many :votes, as: :target # the votes for the answer

  # validation
  validates :description, :user_id, :question_id, { presence: true }

  validate :valid_user, :uniq_best_answer

  def valid_user
    # creator of question cannot answer own question
    # changed the line below because it was comparing the user_id of the answer to the user id of the answer creator
    if user_id == self.question.user.id
      return errors.add :user, "cannot answer their own questions"
    end

    # one user cannot make two answers
    current_answerers = self.question.answers.map { |answer| answer.user_id }
    if current_answerers.include?(user_id)
      return errors.add :user, "cannot answer the same question more than once"
    end
  end

  # check if best answer already exists
  def uniq_best_answer
    current_best_answer = self.question.best_answer
    if current_best_answer && self.best_answer == 1
      unless current_best_answer == self
        errors.add :question, "can only have at most 1 best answer"
      end
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

  def upvoted_by?(user_id)
    !!(self.votes.find { |vote| vote.user_id == user_id && vote.value == 1 })
  end

  def downvoted_by?(user_id)
    !!(self.votes.find { |vote| vote.user_id == user_id && vote.value == -1 })
  end
end
