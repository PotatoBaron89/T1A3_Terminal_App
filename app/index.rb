# frozen_string_literal: true
require 'colorize'
require_relative '../app/controllers/session_controller'
require_relative './../lib/modules/members'

Membership.setup_db
#    ---  SIGN-IN
while defined?(session) == nil || (session.is_authenticated == false)
begin

  is_authenticated, session = SessionController.sign_in
  if is_authenticated
    puts "Signed in as: #{session}"
  else
    raise IncorrectLogin
  end
rescue IncorrectLogin
  retry
end
end

#    ---  MENU
# Menu >> | Flashcards | Study | Settings | Help | Logout | Exit

while session.is_authenticated

end
