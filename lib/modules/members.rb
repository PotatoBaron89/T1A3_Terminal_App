# frozen_string_literal: true

require_relative '../exceptions/bad_username'
require_relative '../exceptions/bad_password'
require_relative '../exceptions/user_exists'
require_relative '../exceptions/standard_error'
require_relative './utilities'

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
    puts "User entered: #{username = self::Utils.request_username}"
    puts "User entered: #{password = self::Utils.request_password}"
    Utilities::Data.lookup(Utilities.user_db, username, password)
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
      { username.to_sym => { username: username, password: password } }, Utilities.user_db
    )
    puts 'You are now registered.'
  rescue UserExists => e
    StandardError.let_user_retry(e)
    retry
  end

  def self.setup_db
    # Check files exist, else create
    # Must be a cleaner way
    Dir.mkdir('../../cache') unless Dir.exist?('../../cache')
    Dir.mkdir('../../cache/place_holder_db') unless Dir.exist?('../../cache/place_holder_db')
    File.new('../../cache/place_holder_db/users.json', 'w') unless File.exist?(Utilities.user_db)
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
      system 'clear'
      puts e
      gets
      retry
    end

    def self.request_password
      system 'clear'
      print 'Password: '
      password = Utilities.hide_req_input
      raise BadUsername, "Invalid password. Can't be less than 6 characters" if password.length < 6

      password

    rescue BadUsername => e
      system 'clear'
      puts e
      gets
      retry
    end

    def self.user_exists?(username)
      Utilities::Data.lookup(Utilities.user_db, username)
    end

    def self.get_password(username)
      Utilities::Data.lookup(Utilities.user_db, username, :password)
    end
  end

end

Membership.setup_db
Membership.authenticate_user('abc', '12345678', JSON.parse(File.read(Utilities.user_db)))
Membership.register