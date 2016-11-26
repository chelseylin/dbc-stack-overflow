class Answer < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user # the user created the answer
  belongs_to :question # the question the answer belongs to
  has_many :comments, as: :content # the comments for the answer
  has_many :votes, as: :target # the votes for the answer

  # validation
  validates :description, :user_id, :question_id, { presence: true }

  validate :valid_user

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

  def vote_count
    votes = self.votes.to_a.map!{|vote| vote.value }.reduce(:+)
    if votes == nil
      return 0
    else
      return votes
    end
  end
end
