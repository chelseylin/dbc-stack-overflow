class User < ActiveRecord::Base
  # Associations
  has_many :questions # questions the user asked
  has_many :answers # answers the user answered
  has_many :comments # comments the user commented
  has_many :votes # votes the user made

  # Validations
  validates :user_name, { presence: true, uniqueness: true }
  validate :valid_password

  def valid_password
    if @plain_password == nil || @plain_password.empty? # check for empty password
      return errors.add :password, "can't be blank"
    end

    unless @plain_password.length >= 6 # at least 6 characters long
      return errors.add :password, "must be at least 6 characters"
    end
  end

  include BCrypt

  def password
    @password ||= Password.new(self.hash_password)
  end

  def password=(new_password)
    @plain_password = new_password
    @password = Password.create(new_password)
    self.hash_password = @password
  end
end
