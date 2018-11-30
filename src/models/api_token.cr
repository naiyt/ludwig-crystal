class ApiToken < Granite::Base
  adapter pg
  table_name api_tokens

  primary id : Int64
  field token : String
  field user_id : Int32
  field expires_at : Time
  timestamps

  before_create :generate_token

  belongs_to :user

  def expired?
    # if guards don't work with instance variables: https://crystal-lang.org/docs/syntax_and_semantics/if_var.html
    (expires_at = @expires_at) ? expires_at < Time.now : false
  end

  def expire
    @expires_at = Time.utc(1900, 2, 15, 10, 20, 30)
    save!
  end

  private def generate_token
    @token = Random.new.hex
  end
end
