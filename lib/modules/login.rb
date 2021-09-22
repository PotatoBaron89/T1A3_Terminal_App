# frozen_string_literal: true
require 'passwordmasker'
require_relative '../exceptions/bad_username'
require_relative './utils.rb'

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
# @dependencies ::: passwordmasker
module Membership
  def self.login
    puts "User entered: #{self::Utils.request_username}"
    puts "User entered: #{self::Utils.request_password}"
  end

  def self.logout
    puts 'Placeholder logout'
  end

  def self.register
    puts 'Placeholder register'
  end

  # Provides behind the sceens utils to allow module to function
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

      raise BadUsername, 'Invalid username... Minimum three characters. No special characters' if password.length < 3

      password

    rescue BadUsername => e
      system 'clear'
      puts e
      gets
      retry
    end
  end


end

Membership.login