# frozen_string_literal: true
#
class InvalidOption < StandardError
  def initialize(msg = 'Provided selection did not match any known options')
    super(msg)
  end
end