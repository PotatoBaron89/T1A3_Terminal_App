# frozen_string_literal: true
require 'colorize'
require 'tty-box'

require_relative './../lib/modules/members'
require_relative 'controllers/display_controller'
require_relative '../lib/modules/lesson'
require_relative '../lib/modules/curriculum'
require_relative './controllers/user_controller'
require 'dotenv'
Dotenv.load('../.env')

Curriculum.setup_lesson_info
Membership.setup_db
session = Session.new('Guest', false)

#    ---  SIGN-IN

until session.is_authenticated
  puts DisplayController.display_splash
  session = DisplayController.sign_in("Welcome #{session}, What would you like to do?".colorize(:yellow))

  handle_failed_login = lambda {
    if DisplayController.yes_no('Would you like to register an account?')
      session = Membership.register
    end
  }

  handle_failed_login.call unless defined?(session).nil? == false && session.is_authenticated
  Session::USER[:setup_user_cache].call(session.username)
  session.vocab = Session::USER[:load_session].call(session)

  unless session.is_authenticated == false
    puts "Welcome #{session.username.colorize(:yellow)}!"
    gets
    break
  end
  # handle_failed_login.call
end


session.request_userinfo
while session.is_authenticated
  DisplayController.main_menu(session)
end
