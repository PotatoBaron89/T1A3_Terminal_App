# frozen_string_literal: true

require_relative '../exceptions/bad_username'
require_relative '../exceptions/bad_password'
require_relative '../exceptions/user_exists'
require_relative '../exceptions/standard_error'
require_relative '../exceptions/incorrect_login'
require_relative './utilities'
require_relative './session'

# DOCUMENTATION
#
# @description Handles Logic and display for login, logout, register
# @method --- login
#     @info sends user to login screen
# @method --- logout
#     @info sends user to logout screen
# @method --- register
#     @info sends user to registration screen
#
module Membership
  include BCrypt

  def self.authenticate_user(username, password, list_of_users)
    puts 'Authenticating'

    list_of_users.each do |user_info|
      next unless user_info[username.to_s]['username'] == username &&
                  verify_hash_digest(user_info[username.to_s]['password']) == password

      puts 'Successfully logged in'
      gets
      return true
    rescue NoMethodError => e
      # log error
      puts 'Incorrect login information required'
      return false
    end
    # Look ended, no match found, give error and let user retry
    raise IncorrectLogin
  rescue IncorrectLogin => e
    StandardError.let_user_retry(e)
    retry
  end

  def self.verify_hash_digest(password)
    BCrypt::Password.new(password)
  end

  def self.login
    username = self::Utils.request_username
    password = self::Utils.request_password

    if Membership.authenticate_user(username, password, Utilities.user_db_get)
      [true, session = Session.new(username)]
    else
      [false, session = nil]
    end
  end

  def self.logout
    puts 'Placeholder logout'
  end

  def self.register
    # Get User's Desired Username
    puts 'Create a new account.'
    username = self::Utils.request_username
    # Check whether Username is already in use
    raise UserExists if self::Utils.user_exists?(username)

    # Get User's Desired Password and Salt it, Utils.request handles PW Requirements.
    password = Utilities.salt_data(self::Utils.request_password)

    # Append data to user_db
    Utilities::Data.append_data(
      { username.to_sym => { username: username, password: password } }, Utilities.user_db_link
    )
    puts 'You are now registered.'

    # Return Successful login and session information
    [true, Session.new(username)]
  rescue UserExists => e
    StandardError.let_user_retry(e)
    retry
  end

  # prob should be elsewhere
  def self.setup_db
    # Check that folder struct exists, create if not
    Dir.mkdir('../cache') unless File.exist?('../cache')
    Dir.mkdir('../cache/place_holder_db/')unless File.exist?('../cache/place_holder_db/')
    unless File.exist?(Utilities.user_db_link)
      file = File.new('../cache/place_holder_db/users.json', 'w')
      file.puts('[]')
      file.close
    end
    gets
  end

  # Provides behind the scenes utils to allow module to function
  module Utils
    def self.request_username
      system 'clear'
      print 'Username: '

      username = gets.chomp
      raise BadUsername, 'Invalid username... Minimum three characters. No special characters' if username.length < 3

      username
    rescue BadUsername => e
      StandardError.let_user_retry(e)
      retry
    end

    def self.request_password
      system 'clear'
      print 'Password: '
      password = Utilities.hide_req_input
      raise BadUsername, "Invalid password. Can't be less than 6 characters" if password.length < 6

      password

    rescue BadUsername => e
      StandardError.let_user_retry(e)
      retry
    end

    def self.user_exists?(username)
      Utilities::Data.lookup(Utilities.user_db_link, username)
    end

    def self.get_password(username)
      Utilities::Data.lookup(Utilities.user_db_link, username, :password)
    end
  end
end
