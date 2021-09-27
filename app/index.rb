# frozen_string_literal: true
require 'colorize'
require 'tty-box'

require_relative './../lib/modules/members'
require_relative 'controllers/display_controller'
require_relative '../lib/modules/lesson'
require_relative '../lib/modules/curriculum'
require 'dotenv'
Dotenv.load('../.env')


Curriculum.setup_lesson_info



Membership.setup_db
session = Session.new('Guest', false)

#    ---  SIGN-IN

until session.is_authenticated
  puts DisplayController.display_splash
  gets
  handle_failed_login = -> { Membership.register if DisplayController.yes_no('Would you like to register an account?') }

  session = DisplayController.sign_in("Welcome #{session}, What would you like to do?".colorize(:yellow))
  Session::USER[:setup_user_cache].call(session.username)
  handle_failed_login unless defined?(session).nil? == false && session.is_authenticated

  unless session.is_authenticated == false
    puts "Welcome #{session.username.colorize(:yellow)}!"
    gets
    break
  end
  handle_failed_login.call
end

#    ---  MENU
# Menu >> | Flashcards | Study | Settings | Help | Logout | Exit



module Utilities


  
  def self.parse_lesson(lesson, session)
    puts 'placeholder'
  end
end

### Load Content ###
Utilities.get_lesson_links
#


while session.is_authenticated
  DisplayController.main_menu(session)
end
