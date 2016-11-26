class User < ActiveRecord::Base
  # Associations
  has_many :questions # questions the user asked
  has_many :answers # answers the user answered
  has_many :comments # comments the user commented
  has_many :votes # votes the user made

  # Validations
  validates :user_name, { presence: true, uniqueness: true }
  validate :valid_password

  # def valid_username
  #   unless @user_name.length >= 5 # at least 6 characters long
  #     return errors.add :user_name, "Must be at least 5 characters"
  #   end
  # end

  def valid_password
    if @plain_password == nil || @plain_password.empty? # check for empty password
      return errors.add :password, "can't be blank"
    end

    unless @plain_password.length >= 6 # at least 6 characters long
      return errors.add :password, "Must be at least 6 characters"
    end

    reg = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}$/
    if ((reg.match(@plain_password))? true : false) == false
      return errors.add :password, "Must contain at least one letter and one number"
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

  def authenticate(plain_password)
    self.password == plain_password
  end
end
