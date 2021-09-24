# frozen_string_literal: true

begin
  require 'tty-prompt'
  require 'tty-font'
rescue LoadError
  puts 'You appear to be missing dependencies. Try run:'
  puts '"bundle install"'.colorize(:yellow)
end

require_relative '../../lib/modules/members'
require_relative 'user_controller'

# Documentation Needed
module DisplayController
  include UserController

  def self.display_splash
    puts 'placeholder splash screen from DisplayController'
  end

  def self.print_message(msgs, pause: true)
    prompt = TTY::Prompt.new(quiet: true)
    msgs.each do |msg|
      puts msg
      prompt.keypress('Press any key to continue...')
    end
  end

  def self.prompt(msg)
    res = TTY::Prompt.new.ask('Username: ')
    puts "Res: #{res}"
  end

  def self.yes_no(msg)
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'yes', true
      menu.choice 'no', false
    end
  end

  def self.sign_in(msg = 'What would you like to do')
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'Login', USER[:return_new_session]
      menu.choice 'Register', USER[:register_plus_new_session]
      menu.choice 'Help'
      menu.choice 'Close'
    end
  end

  def self.main_menu(msg = 'Main Menu'.colorize(:yellow))
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'Flash Cards'
      menu.choice 'Study'
      menu.choice 'Profile'
      menu.choice 'Settings'
      menu.choice 'About'
      menu.choice 'Logout'
      menu.choice 'Close'
    end
  end

  def self.flash_card_menu(msg = "Welcome #{session.username}, please select a list to study")
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'Greetings and Introductions'
      menu.choice 'Verbs'
      menu.choice 'Adjectives'
      menu.choice 'Back'
    end
  end



end