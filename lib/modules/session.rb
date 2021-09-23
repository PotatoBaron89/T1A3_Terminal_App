# frozen_string_literal: true

# @title Session
#
# @tasks: Store use session info
# @tasks: Pull relevant information from DB (or pseudo db in our case)
class Session
  attr_reader :name
  def initialize(username)
    @username = username
  end

  def to_s
    @username
  end

  def sign_out
    puts 'Placeholder sign-out'
  end
end


