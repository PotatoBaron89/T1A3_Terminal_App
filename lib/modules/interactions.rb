# frozen_string_literal: true

##
#  This module handles overrides and addition settings for Remedy's interaction class

module Remedy
  class Interaction
    def quit!
      confirm 'Are you sure you want to quit? Your data will be saved' do
        ANSI.cursor.home!
        ANSI.command.clear_down!
        ANSI.cursor.show!

        puts " -- Bye :)"
        exit
      end
    end

    def debug!
      require 'irb'
      binding.irb
    end
  end
end