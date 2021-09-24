# frozen_string_literal: true

# @Description: Prints a list of available commands
def default_user_opts
  # Probs should move options and commands elsewhere and call them
  # Define Available options
  options = [
    { flashcards: 'Use flashcards to learn' },
    { study: 'Unavailable' },
    { profile: 'Displays your profile and statistics' },
    { settings: 'Opens settings panel' },
    { help: 'displays available commands' },
    { logout: 'sign out' },
    { exit: 'exit application' }
  ]

  # Define Available Commands
  commands = [
    { session: '|Not Implemented| Display current session information' },
    { lookup: '|Not Implemented| Lookup current word (if studying), else lookup defined word, eg "lookup bon"' },
    { stats: '|Not Implemented| Get your stats for word (if studying), else stats for defined word, eg "stats bon"' }
  ]

  puts '   |   Help   | << Type in any of the below options or commands >>'
  puts '   |  Options | primary functions'
  puts '   | Commands | helper functions that provide some information'

  # Print each option and its description
  options.each { |opt| puts "#{opt.keys[0]} : #{opt.values[0]}" }
  puts '- - - - - - - - - - - - - - - - - - - - - - - - -'
  # Print each command and its description
  commands.each { |opt| puts "#{opt.keys[0]} : #{opt.values[0]}" }
end