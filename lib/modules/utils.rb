# @Description
# Provides common tools required through the application
module Utilities
  def self.hide_req_input
    system 'stty -echo'
    hidden_data = gets.chomp
    system 'stty echo'
    hidden_data
  end
end
