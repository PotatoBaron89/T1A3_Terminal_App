# frozen_string_literal: true
#
class UserExists < StandardError
  def initialize(msg = 'Unfortunately this username is already taken. Please try another')
    super(msg)
  end
end
