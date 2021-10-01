# frozen_string_literal: true
require 'colorize'
require 'tty-box'

require_relative './../lib/modules/members'
require_relative 'controllers/display_menus'
require_relative '../lib/modules/lesson'
require_relative '../lib/classes/curriculum'

require 'dotenv'
Dotenv.load('../config.env')

Curriculum.setup_lesson_info
Membership.setup_db

# Process Commandline args > Setup session if command line login success
session = Utilities.check_args

if session.is_authenticated
  Session::USER[:setup_user_cache].call(session.username)
  session.vocab = Session::USER[:load_session].call(session)
end

# Display Slashscreen

puts DisplayMenus.display_splash if ENV["SKIP_SPLASH"] == 'false'

# --- Start Loop to let user try login / register until successful or quit
active = true
while active == true

  #    ---  Start Core Loop if Authenticated
  while session.is_authenticated
    DisplayMenus.main_menu(session)
  end

  #    ---  SIGN-IN
  until session.is_authenticated


    session = DisplayMenus.sign_in("Welcome #{session}, What would you like to do?".colorize(:yellow))

    handle_failed_login = lambda {
      if DisplayMenus.yes_no('Would you like to register an account?')
        session = Membership.register
      end
    }

    handle_failed_login.call unless defined?(session).nil? == false && session.is_authenticated
    Session::USER[:setup_user_cache].call(session.username)
    session.vocab = Session::USER[:load_session].call(session)

    unless session.is_authenticated == false
      puts "Welcome #{session.username.colorize(:yellow)}!"
      session.request_userinfo
      STDIN.gets
    end

    # session.request_userinfo

    # look session while logged in
  end
end




