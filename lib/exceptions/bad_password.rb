# frozen_string_literal: true
#
class BadPassword < StandardError
  def initialize(msg = 'Invalid Password')
    super(msg)
  end
end
