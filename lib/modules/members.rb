# frozen_string_literal: true

require_relative '../exceptions/bad_username'
require_relative '../exceptions/bad_password'
require_relative '../exceptions/user_exists'
require_relative '../exceptions/standard_error'
require_relative '../exceptions/incorrect_login'
require_relative './utilities'
require_relative './session'

# DOCUMENTATION

module Membership
  include BCrypt

  def self.authenticate_user(username, password)
    system 'clear'
    Utilities.user_db_get.each do |user_info|

      next unless user_info.keys[0] == username.to_sym &&
      verify_hash_digest(user_info.values[0][:password]) == password

       return true

    rescue NoMethodError
      puts 'Incorrect login information provided'
      return false
    end
    # Look ended, no match found, give error and let user retry
    raise IncorrectLogin
  rescue IncorrectLogin => e
    StandardError.let_user_retry(e)
    return false
  end

  def self.verify_hash_digest(password)
    BCrypt::Password.new(password)
  end

  def self.login(username = nil, password = nil)
    system 'clear'
    username == nil ? arg_passed = false : arg_passed = true

    #check if params were passed, if not, request details
    if username == nil && password == nil
      puts 'Login to your account.'
      username = self::Utils.request_username
      password = self::Utils.request_password
    end

    if self.authenticate_user(username, password)
      Session.new(username, true)
    else
      Session.new('Guest', false)
    end
  end

  def self.logout
    puts 'Placeholder logout'
  end

  # @description Register provides prompts to setup account
  # @return Returns a session object
  def self.register
    system 'clear'

    puts 'Create a new account.'
    # Get username > check not taken > get password > hash password
    username = self::Utils.request_username
    raise UserExists if self::Utils.user_exists?(username)

    password = Utilities.salt_data(self::Utils.request_password)
    Utilities::Data.append_data(
      { username.to_sym => { username: username, password: password } }, Utilities.user_db_link
    )
    puts 'You are now registered.'

    # Return Successful login and session information
    Session.new(username, true)

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
  end

  # Provides behind the scenes utils to allow module to function
  module Utils
    def self.request_username
      print 'Username: '

      username = STDIN.gets.chomp
      raise BadUsername, 'Invalid username... Minimum three characters. No special characters' if username.length < 3

      username
    rescue BadUsername => e
      StandardError.let_user_retry(e)
      retry
    end

    def self.request_password
      print 'Password: '
      password = Utilities.hide_req_input
      raise BadUsername, "Invalid password. Can't be less than 6 characters" if password.length < 6

      password

    rescue BadUsername => e
      StandardError.let_user_retry(e)
      retry
    end

    def self.user_exists?(username)
      Utilities::Data.lookup(Utilities.user_db_link, username.to_sym)
    end

    def self.get_password(username)
      Utilities::Data.lookup(Utilities.user_db_link, username.to_sym, :password)
    end
  end
end
