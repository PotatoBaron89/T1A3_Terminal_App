require_relative('../views/login_form')
require_relative '../../lib/exceptions/invalid_option'
require_relative '../../lib/modules/members'

# Handles Session Management, Session required to enter main app
module SessionController
  def self.sign_in
    return if defined?(session)

    options = %w[login register help exit]
    Views.sign_in(options.each { |_| })
    res = gets.chomp

    until options.include?(res)
      system 'clear'
      Views.sign_in(options.each { |_| })
      puts 'Invalid option selected, please type one of the above options'
      res = gets.chomp
    end

    case res
    when 'login'
      Membership.login
    when 'register'
      Membership.register
    else
      puts 'That option is not implemented yet'
      gets
    end
  end
end

