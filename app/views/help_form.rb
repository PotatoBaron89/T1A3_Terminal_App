# frozen_string_literal: true
require_relative 'views'
require_relative '../helpers/print_options'
require_relative '../helpers/default_user_opts'

# Append help method to Views
module Views
  # Display help form
  # For default options, use NO params
  # @param optional, if custom help wanted enter an array with objects as displayed below.
  # { :option_name => 'What option_name does'}
  # Objects must be wrapped in an array
  def self.help(*custom_params)
    # Implement Custom Params (Backlog)
    system 'clear'
    puts 'Options'
    puts
    default_user_opts
  end
end