# frozen_string_literal: true
#
class BadUsername < StandardError
  def initialize(msg = 'Invalid Username')
    super(msg)
  end
end