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
require_relative 'display_controller_procs'

# Documentation Needed
module DisplayController
  include UserController
  @prompt = TTY::Prompt.new

  def self.display_splash
    system 'clear'
    TTY::Box.frame('Apprenons-en Français!', align: :center, padding: 3, width: 30, height: 10, title: {top_left: "By Sam O'Donnell", bottom_right: 'v0.03'})
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

    @prompt.select(msg) do |menu|
      menu.choice 'Login', USER[:return_new_session]
      menu.choice 'Dev Mode', -> { Session.new('sam', true) }
      menu.choice 'Register', USER[:register_plus_new_session]
      menu.choice 'Close', -> { exit(true) }
    end

  end

  def self.main_menu(session, msg = 'Main Menu')
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'Study', -> { study_menu(session) }
      menu.choice 'Flash Cards', -> { flash_card_menu(session) }
      menu.choice 'Profile'.colorize(:black)
      menu.choice 'Settings'.colorize(:black)
      menu.choice 'About'.colorize(:black)
      menu.choice 'Logout', -> { session.sign_out }
      menu.choice 'Close', -> { exit(true) }
    end
  end

  def self.flash_card_menu(session, msg = 'Select a list to study')
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'Greetings and Introductions'.colorize(:black)
      menu.choice 'Verbs'.colorize(:black)
      menu.choice 'Adjectives'.colorize(:black)
      menu.choice 'Back', -> { main_menu(session) }
    end
  end

  def self.study_menu(session, msg = 'Select a module to study')
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      Curriculum.lessons.each_with_index do |lesson, i|
        menu.choice "#{lesson.difficulty} :  #{lesson.title}", -> { DISPLAY[:lesson_info].call(i, session) }
      end
        menu.choice 'Back', -> { main_menu(session) }
    end
  end
end


