require "./spec_helper"
require "../../src/models/api_token.cr"

# TODO: DRY these up
def create_user
  user = User.new({"email" => "lantus@levemir.com", "singleton" => true})
  user.password = "overpriced"
  user.save!
  user
end

def create_token(user : User, expires_at : Time | Nil)
  ApiToken.create({"user_id" => user.id, "expires_at" => expires_at})
end

describe ApiToken do
  Spec.before_each do
    ApiToken.clear
    User.clear
  end

  describe "callbacks" do
    describe "before_create" do
      describe "#generate_token" do
        it "generates and saves the token" do
          user = create_user
          token = create_token(user, nil)
          token.token.should_not eq(nil)
        end
      end
    end
  end

  describe "#expired?" do
    it "returns false if expires_at is nil" do
      user = create_user
      token = create_token(user, nil)
      token.expired?.should be_false
    end

    it "returns false if expires_at is in the future" do
      user = create_user
      token = create_token(user, Time.utc(2200, 2, 15, 10, 20, 30))
      token.expired?.should be_false
    end

    it "returns true if expires_at is in the past" do
      user = create_user
      token = create_token(user, Time.utc(1920, 2, 15, 10, 20, 30))
      token.expired?.should be_true
    end
  end

  describe "#expire" do
    it "sets the expires_at date to a point in the far past" do
      user = create_user
      token = create_token(user, nil)
      token.expire
      token.expired?.should be_true
      token.expires_at.should_not be_nil
    end
  end
end
