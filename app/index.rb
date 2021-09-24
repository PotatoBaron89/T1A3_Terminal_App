# frozen_string_literal: true
require 'colorize'
require_relative './../lib/modules/members'
require_relative 'controllers/display_controller'

Membership.setup_db
session = Session.new('Guest', false)

#    ---  SIGN-IN

until session.is_authenticated
  handle_failed_login = -> { Membership.register if DisplayController.yes_no('Would you like to register an account?') }

  session = DisplayController.sign_in(session)
  handle_failed_login unless defined?(session).nil? == false && session.is_authenticated

  unless session.is_authenticated == false
    DisplayController.print_message(["Welcome #{session.username.colorize(:yellow)}!"])
    break
  end
  handle_failed_login.call
end

#    ---  MENU
# Menu >> | Flashcards | Study | Settings | Help | Logout | Exit

while session.is_authenticated
  DisplayController.main_menu
end
