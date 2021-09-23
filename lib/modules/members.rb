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

    Membership.authenticate_user(username, password, Utilities.user_db_get)

  end

  def self.logout
    puts 'Placeholder logout'
  end

  def self.register
    puts 'Create a new account.'
    puts "User entered: #{username = self::Utils.request_username}"
    raise UserExists if self::Utils.user_exists?(username)

    puts "User entered: #{password = Utilities.salt_data(self::Utils.request_password)}"
    Utilities::Data.append_data(
      { username.to_sym => { username: username, password: password } }, Utilities.user_db_link
    )
    puts 'You are now registered.'
  rescue UserExists => e
    StandardError.let_user_retry(e)
    retry
  end

  # prob should be elsewhere
  def self.setup_db

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