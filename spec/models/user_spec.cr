require "./spec_helper"
require "../../src/models/user.cr"

# TODO: would be nice to have some sort of factory for these
def user_params
  {
    "email" => "agent47@ica.com",
    "password" => "TobiasRieper",
    "singleton" => true,
  }
end

def create_user
  user = User.new
  user.set_attributes(user_params)
  user.password = user_params["password"].as(String)
  user.save!
  user
end

describe User do
  Spec.before_each do
    User.clear
  end

  describe "#password=" do
    it "hashes the password" do
      user = create_user
      hashed_password_before = user.hashed_password
      password = "We all have barcodes on the back of our heads"
      user.password = password
      user.save!
      new_user = User.find!(user.id) # No reload?
      new_user.hashed_password.should_not eq(hashed_password_before)
      new_user.hashed_password.should_not eq(password)
      new_user.hashed_password.as(String).size.should eq(60)
    end
  end

  describe "#password" do
    it "returns the bcrypted password" do
      user = create_user
      user.password.to_s.should eq(user.hashed_password)
    end
  end

  describe "#password_matches?" do
    it "returns false if the password hashes don't match" do
      user = create_user
      user.password_matches?("1337hackers").should be_false
    end

    it "returns true if the password hashes match" do
      user = create_user
      user.password_matches?(user_params["password"].as(String)).should be_true
    end
  end
end
