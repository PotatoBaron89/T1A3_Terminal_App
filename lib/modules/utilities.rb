require 'bcrypt'
require 'json'

# @Description
# Provides common tools required through the application
module Utilities
  def self.user_db
    '../../cache/place_holder_db/users.json'
  end

  def self.hide_req_input
    system 'stty -echo'
    hidden_data = gets.chomp
    system 'stty echo'
    hidden_data
  end

  def self.salt_data(data_to_hash)
    BCrypt::Password.create(data_to_hash)
  end

  def self.salted_match?(str_to_check, salted_data)
    str_to_check == salted_data
  end

  # Module handles data input / output
  module Data
    def self.append_data(data_to_append, file_location)
      data = JSON.parse(File.read(file_location))
      data << data_to_append

      File.open(file_location, 'w') do |f|
        f.write(JSON.pretty_generate(data))
      end
    end

    def self.lookup(file_location, string_to_search)
      data = JSON.parse(File.read(file_location), { symbolize_keys: true })

      puts "lookup -- #{string_to_search}"
      data.each do |d|
        if d.keys[0] == string_to_search
          puts d.keys[0]
          return true
        end
      end
      false
    end
  end
end
