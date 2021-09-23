require_relative 'views'
require_relative '../helpers/print_options'
# frozen_string_literal: true

# Display Sign in form
module Views
  def self.sign_in(*args)
    system 'clear'
    puts 'Welcome to My App that needs a name :)'
    puts
    print_options('What would you like to do? ', *args)
  end
end


