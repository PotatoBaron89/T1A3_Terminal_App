# # frozen_string_literal: true

#
module UserController
  # description: handles user input
  def handle_input(input, session)
    case input
    when 'flashcards'
      puts 'placeholder flashcards from user_controller'
    when 'study'
      puts 'placeholder study from user_controller'
    when settings || options
      puts 'placeholder settings / options from user_controller'
    when 'profile'
      puts 'placeholder profile from user_controller'
    when 'logout'
      puts 'Logging out'
      session.is_authenticated = false
    when 'end'
      puts 'closing application'
      exit
    when 'help'
      puts 'placeholder help from user_controller'
    else
      puts 'Unrecognized input.  Type "help" for a list of valid commands'
    end
  end
end
