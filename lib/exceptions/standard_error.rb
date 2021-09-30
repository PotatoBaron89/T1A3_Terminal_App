# frozen_string_literal: true
#
class StandardError
  def self.let_user_retry(msg)
    system 'clear'
    puts msg
    STDIN.gets
  end
end
