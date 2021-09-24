require_relative 'display_controller'
require_relative('../views/login_form')
require_relative '../../lib/exceptions/invalid_option'
require_relative '../../lib/modules/members'
require_relative '../../lib/modules/session'

# Handles Session Management, Session required to enter main app
module SessionController
  def self.sign_in
    return if defined?(session)

    res = DisplayController.sign_in.downcase

    case res
    when 'login'
      is_authenticated, session = Membership.login
      [is_authenticated, session]
    when 'register'
      Membership.register
    else
      puts 'That option is not implemented yet'
      gets
    end
  end
end

