# frozen_string_literal: true
require_relative '../app/controllers/session_controller'
require_relative './../lib/modules/members'

begin # SIGNIN
  Membership.setup_db

  if SessionController.sign_in
  puts 'Signed in'
  else
    puts 'test'
  end
end
