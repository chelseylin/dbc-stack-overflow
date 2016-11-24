class Vote < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :target, polymorphic: true

  # Validations
  validates :value, :user_id, :target_type, :target_id, { presence: true }
  validate :valid_value
  validate :valid_voter

  def valid_value
    unless value == 1 || value == -1
      errors.add :value, "is invalid"
    end
  end

  def valid_voter
    current_voters = self.target.votes.map { |vote| vote.user_id }
    if current_voters.include?(user_id)
      errors.add :user, "cannot vote same item twice"
    end
  end
end
