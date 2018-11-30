require "../config/application.cr"

# Temporary seed for setting up the main admin user. Eventually
# this will go away in favor of invites and user permission levels.

if User.count > 0
  raise "User already exists; current functionality only allows for a single user!"
else
  user = User.new
  user.email = ENV["EMAIL"]
  user.password = ENV["PASSWORD"]
  user.singleton = true
  user.save!
end
