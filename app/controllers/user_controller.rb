# # frozen_string_literal: true

#
module UserController
  USER = {
    return_new_session: -> { Membership.login },
    register_plus_new_session: -> { Membership.register }
  }.freeze
end
