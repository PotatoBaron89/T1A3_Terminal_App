require 'bcrypt'
require 'json'

# require_relative '../../cache/place_holder_db/users.json'

# @Description
# Provides common tools required through the application
module Utilities
  def self.user_db_link
    '../cache/place_holder_db/users.json'
  end

  def self.get_lesson_links
    Dir['../lib/res/fr-lessons/*.json']
  end

  def self.get_flashcard_links
    Dir['../lib/res/fr_vocab/*.json']
  end

  def self.user_db_get
    JSON.parse(File.read(user_db_link), { symbolize_names: true })
  end

  # should refactor with user_db to prevent redundancy
  # Returns a parsed json file
  def self.load_json(file)
    return JSON.parse(File.read(file), { symbolize_names: true }) if file.is_a? String

    if file.is_a? Array
      file.each { |f| JSON.parse(File.read(f), { symbolize_names: true }) }
    end
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

  def self.req_info(str_prompt)
    print str_prompt
    gets.chomp
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

    def self.lookup(file_location, value_to_search, *args)
      data = JSON.parse(File.read(file_location), { symbolize_names: true })

      data.each do |d|
        if d.keys[0] == value_to_search
          return true
        end
      end
      false
    end
  end
end
