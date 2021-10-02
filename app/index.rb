# frozen_string_literal: true
begin
  require 'colorize'
  require 'tty-box'
rescue LoadError
  puts 'You appear to be missing dependencies. Try run:'
  puts '"bundle install"'.colorize(:yellow)
end


require_relative './../lib/modules/members'
require_relative 'controllers/display_menus'
require_relative '../lib/modules/lesson'
require_relative '../lib/classes/curriculum'

require 'dotenv'
Dotenv.load('../config.env')

# Load Metadata for lessons
Curriculum.setup_lesson_info
Membership.setup_db

# Process Commandline args > Setup session if command line login success
session = Utilities.check_args

# Setup user session in case of successful console login
if session.is_authenticated
  Session::USER[:setup_user_cache].call(session.username)
  session.vocab = Session::USER[:load_session].call(session)
end

# Display Slashscreen unless disabled
puts DisplayMenus.display_splash if ENV["SKIP_SPLASH"] == 'false'


active = true
#    ---  Start Core Loop
while active == true

  #    ---  Start Loop of Content if session is authenticated
  while session.is_authenticated
    DisplayMenus.main_menu(session)
  end

  #    ---  SIGN-IN
  # # --- Start Loop to let user try login / register until successful or quit
  until session.is_authenticated
    # Display sign in forms, return session (can be authenticated or unauthenticated session)
    session = DisplayMenus.sign_in("Welcome #{session}, What would you like to do?".colorize(:yellow))

    # Define Proc to handle failed login attempts
    handle_failed_login = lambda {
      if DisplayMenus.yes_no('Would you like to register an account?')
        session = Membership.register
      end
    }

    # Call proc to handle failed login attempt if session does not exist or is not authenticated
    handle_failed_login.call unless defined?(session).nil? == false && session.is_authenticated

    Session::USER[:setup_user_cache].call(session.username)
    session.vocab = Session::USER[:load_session].call(session)

    unless session.is_authenticated == false
      puts "Welcome #{session.username.colorize(:yellow)}!"
    end

    # session.request_userinfo

    # look session while logged in
  end
end




