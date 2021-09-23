# frozen_string_literal: true
require_relative '../app/controllers/session_controller'
require_relative './../lib/modules/members'

begin # SIGNIN
  Membership.setup_db

  is_authenticated, session = SessionController.sign_in
  if is_authenticated
    puts "Signed in as: #{session}"
  else
    puts 'test'
  end
end
