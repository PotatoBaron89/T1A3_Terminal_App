# frozen_string_literal: true

begin
  require 'tty-prompt'
  require 'tty-font'
rescue LoadError
  puts 'You appear to be missing dependencies. Try run:'
  puts '"bundle install"'.colorize(:yellow)
end

require_relative '../../lib/modules/members'

# Documentation Needed
module DisplayController
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

  def self.sign_in(msg = 'What would you like to do')
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'Login'
      menu.choice 'Register'
      menu.choice 'Help'
      menu.choice 'Close'
    end
  end
end