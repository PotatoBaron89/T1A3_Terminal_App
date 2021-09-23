# frozen_string_literal: true
#
class IncorrectLogin < StandardError
  def initialize(msg = 'Incorrect Username and or password provided, please try again.')
    super(msg)
  end
end