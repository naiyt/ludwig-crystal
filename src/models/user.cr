require "crypto/bcrypt/password"

# I'm keeping the majority of the validations at the database level right now.
# In Rails I would probably duplicate them on the model level, but seems like
# extra work in amber, and it's not really necessary.

class User < Granite::Base
  include Crypto
  adapter pg
  table_name users

  primary id : Int64
  field! email : String
  field! hashed_password : String
  # This is a temporary column to be used to ensure we only have one user for now, until I implement
  # permission levels
  field! singleton : Bool
  timestamps

  has_many :api_tokens

  def password=(password)
    @hashed_password = Bcrypt::Password.create(password, cost: 10).to_s
  end

  def password
    Bcrypt::Password.new(hashed_password)
  end

  def password_matches?(password : String)
    self.password == password
  end
end
