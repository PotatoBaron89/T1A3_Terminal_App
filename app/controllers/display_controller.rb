# frozen_string_literal: true

begin
  require 'tty-prompt'
  require 'columnize'
  require 'tty-font'
rescue LoadError
  puts 'You appear to be missing dependencies. Try run:'
  puts '"bundle install"'.colorize(:yellow)
end

require_relative '../../lib/modules/listener'
require_relative '../../lib/modules/members'
require_relative 'display_controller_procs'

# Documentation Needed
module DisplayController
  @prompt = TTY::Prompt.new

  # Returns version of the app from ENV
  def self.version
    return ENV['VERSION']
  end

  def self.display_splash
    system 'clear'
    font = TTY::Font.new(:straight)
    puts TTY::Box.frame(font.write('APPRENONS!').colorize(:light_green), align: :center, padding: 3, width: 60,
                   height: 10, title: {top_left: "|  By Sam O'Donnell  |".colorize(:yellow),
                                       bottom_right: "|  Version: #{DisplayController.version}  |".colorize(:yellow) })
    print_message([' '])
  end

  def self.print_message(msgs, pause: true)
    prompt = TTY::Prompt.new(quiet: true)
    msgs.each do |msg|
      puts msg
      prompt.keypress('Press any key to continue...')
    end
  end

  def self.prompt(msg = 'Username: ')
    return TTY::Prompt.new.ask(msg)
  end

  def self.yes_no(msg)
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice 'yes', true
      menu.choice 'no', false
    end
  end

  def self.sign_in(msg = 'What would you like to do')
    system 'clear'

    @prompt.select(msg) do |menu|
      if ENV['DEVMODE'] == 'true'
        menu.choice 'Dev Mode', -> { Session.new('sam', true) }
      end
      menu.choice 'Login', -> { Membership.login }
      menu.choice 'Register', -> { Membership.register }
      menu.choice 'Close', -> { exit(true) }
    end
  end

  def self.main_menu(session, msg = " |  Main Menu  |        Signed in as: #{session}".colorize(:light_green))
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      if ENV['DEVMODE'] == 'true'
        menu.choice '[In Development] Study', -> { study_menu(session) }
      end
      menu.choice 'Flash Cards', -> { flash_card_menu(session) }
      menu.choice 'Profile', -> { show_profile(session) }
      menu.choice 'About', -> {
        display_splash
        print_message(['App Created By Sam ODonnell', "Version: #{ENV['VERSION']}"])
        main_menu
      }
      menu.choice 'Logout', -> { session.sign_out }
      menu.choice 'Close', -> { exit(true) }
    end
  end

  def self.flash_card_menu(session)
    system 'clear'
    Curriculum.setup_flashcard_lists
    TTY::Prompt.new.select("Select a list to study   Your known words: #{session.vocab[:Vocab].length}") do |menu|

        Curriculum.flashcard_lists.each_with_index do |f_list, i|
          menu.choice "#{i+1}. #{f_list.module_title} ", -> { DisplayController.flash_card_info(i, session) }
        end
        menu.choice 'Back', -> { main_menu(session) }
      end
    end


  def self.show_profile(session, msg = "#{session}'s Profile")
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      menu.choice "Display Name: #{session}", -> { session.change_display_name }
      menu.choice "Username: #{session.username}", -> { show_profile(session) }
      menu.choice "Your learnt vocab [Items: #{session.vocab[:Vocab].length}]",
                  -> { list_known_words(session)
                        show_profile }
      menu.choice 'Back', -> { main_menu(session) }
    end
  end

  def self.list_known_words(session)
    system 'clear'

    TTY::Prompt.new.select("Your known words:") do |menu|
      menu.choice 'Back', -> { main_menu(session) }
      session.vocab[:Vocab].each do |item|
        menu.choice "#{item["english"]}       #{item["translation"].join(' / ')}"
      end
      menu.choice 'Back', -> { main_menu(session) }
    end
  end

  def self.study_menu(session, msg = 'Select a module to study')
    system 'clear'
    TTY::Prompt.new.select(msg) do |menu|
      Curriculum.lessons.each_with_index do |lesson, i|
        menu.choice "#{lesson.difficulty} || #{lesson.desc}", -> { DisplayController.lesson_info(i, session) }
      end
      menu.choice 'Back', -> { main_menu(session) }
    end
  end

  ##
  # @Description Handles User Response to Flash Cards
  # Correct = True     |     Incorrect = False
  def self.correct?(correct)
    DisplayController.print_message(['Correct :)']) if correct
    DisplayController.print_message(['Incorrect, Keep practicing :)']) unless correct
  end

  # Handles Rendering of Flashcards and Awaits User Input, Probably does too much
  def self.prompt_flash_card(word, second_word, session, randomise_prompt = true)
    i = Random.rand(2) if randomise_prompt
    word, second_word = second_word, word if i == 1

    # Proc, Overrides default input handling
    options = Proc.new { |key, session|

      binding.irb if key_to_s == 'back_quote' && ENV['DEVMODE'] == 'true'
      DisplayController.study_menu(session) if key.to_s == 'c'
      DisplayController.main_menu(session) if key.to_s == 'm'
      if key.to_s == 'h'
        DisplayController.print_message(['Entering your results is optional, but if you would like to',
                                        'simply press ↑ arrow for correct and ↓ down arrow for incorrect.'])
      end

      # Override key to break loop
      correct?(true) if key.to_s == 'up'
      correct?(false) if key.to_s == 'down'
    }

    # Display Card One, Options, Await Response
    puts "C: Back    M: To Menu     ↑ :   Mark Correct    ↓ : Mark Incorrect   H :  Help    Any Other :  Next "
    print DisplayController.create_card(word, 'Prompt')
    ListenerContent.new.only_listen(session, &options)

    # Display Card Two, Options, Await Response
    system 'clear'
    puts "C: Back    M: To Menu     ↑ :   Mark Correct    ↓ : Mark Incorrect   H :  Help    Any Other :  Next "
    print DisplayController.create_card(second_word, 'Answer', word)
    ListenerContent.new.only_listen(session, &options)

  end
end


