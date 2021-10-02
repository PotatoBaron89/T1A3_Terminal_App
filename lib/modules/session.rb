# frozen_string_literal: true

begin
  require 'json'
rescue LoadError
  puts 'You appear to be missing dependencies. Try run:'
  puts '"bundle install"'.colorize(:yellow)
end


require_relative '../../app/controllers/display_menus'


##
# @Session
#
# @Purpose: Handles the storage and handling of data related to the user.
# Reponsible for saving, loading and caching user related data.
#
# @use: Initialise with sessions username, and whether that session should qualify as authenticated
class Session
  attr_reader :username
  attr_accessor :is_authenticated, :vocab, :last_word
  include Utilities
  include DisplayMenus

  def initialize(username, is_authenticated = false)
    @username = username
    @display_name = username
    @is_authenticated = is_authenticated
    @vocab = []
    @last_word = ''
  end

  def self.userinfo_key
    return :User_info
  end

  ##
  # @Purpose: Allows user to change their display name
  # @Use: Call, gives user a prompt which will automatically be saved.
  #
  # @NB. Currently does not yet save to users.json
  def change_display_name
    active = true
    while active
      new_name = DisplayMenus.prompt('Display Name: ')
      if new_name.nil? != true
        @display_name = new_name
        break
      end
      active = DisplayMenus.yes_no('Display name must be at least 1 character long. Would you like to try again?')
    end

  end

  ##
  # @Purpose returns userinfo as object
  # Will eventually be responsible for storing user preferences too
  # @returns {"User_info"=>{"username"=>"Sam", "display_name"=>"Sam"}}
  def request_userinfo
    content = { username: username,
                display_name: to_s }

    to_write = JSON.generate("#{Session.userinfo_key}": content)
    to_write = JSON.parse(to_write)
  end

  def to_s
    @display_name
  end

  ##
  # @purpose handles loging out
  # @use requires no params, just session.sign_out.  Active session loop will end.
  def sign_out
    DisplayMenus.print_message(['You have successfully signed out.'])
    @is_authenticated = false
  end

  ##
  # @Purpose Allow user to change their password
  # @use call with session details.
  def change_password(session)
    # Create loop
    system 'clear'
    active = true
    first_attempt = true
    while active
      # Display Prompt, then give user option to abort if they have failed their first attempt
      DisplayMenus.print_message(['Enter your [CURRENT] password'])
      active = DisplayMenus.yes_no('Incorrect details entered, try again?') unless first_attempt

      # Request user's old password
      password = Membership::Utils.request_password
      first_attempt = false
      break if password.nil?

      Utilities.user_db_get.each_with_index do |user_info, i|
        # Loop over each user to match pw
        user_info.each do |user|
          # Check that password is correct

          next unless user[0] == username.to_sym && Membership.verify_hash_digest(user[1][:password]) == password

          # Get new password and save now that we have a match
          file = File.read(Utilities.user_db_link)
          contents = JSON.parse(file, { symbolize_names: true })

          system 'clear'
          DisplayMenus.print_message(['Enter your [NEW] password'])

          # Get new password

          contents[i][user[0]][:password] = Membership::Utils.request_password
          if contents[i][user[0]][:password].nil?
            active = false
            break
          end

          contents[i][user[0]][:password] = Utilities.salt_data(contents[i][user[0]][:password])
          # abort if the user changes their mind

          #Save updated data
          File.open(Utilities.user_db_link, 'w+') { |f| f.write(JSON.pretty_generate(contents)) }
          active = false
        end
      end
    end
  end

  USER = {
    setup_user_cache: lambda { |username|
      Dir.mkdir('../cache') unless File.exist?('../cache')
      Dir.mkdir(USER[:user_dir_path].call()) unless File.exist?('../cache/local_saves/')

      unless File.exists?("../cache/local_saves/#{username}.json")
        File.open("../cache/local_saves/#{username}.json", 'w+') { |f| f.write('{"Vocab":[]}') }
      end
    },
    user_data_path: ->(username) { return "../cache/local_saves/#{username}.json" },

    user_dir_path: -> { return '../cache/local_saves/' },

    # @About Takes word obj and its it to session.vocab
    word_add_to_vocab: lambda { |session, word|
      session.vocab[ENV['VOCAB_KEY'].to_sym].push(word)
    },

    save_session: lambda { |session|
      #Create path to users local save
      vocab_key = ENV['VOCAB_KEY'].to_sym
      users_save_path = USER[:user_data_path].call(session.username)

      # Merge Saved Vocab and Session Vocab, Remove an duplicates
      USER[:get_diff_vocab] if File.exist?(users_save_path)
      hash = File.exist?(users_save_path) ? USER[:get_diff_vocab].call(session, users_save_path) : {}
      session.vocab[vocab_key].uniq!

      if hash.nil?
        to_write = JSON.generate("Vocab": session.vocab[vocab_key])
      else
        to_write = hash[vocab_key].merge(session.vocab[vocab_key]) unless hash[vocab_key].is_a? NilClass
        to_write = hash[vocab_key] ? JSON.generate(to_write) : JSON.generate("Vocab": to_write)
        # request_userinfo
      end

      File.open(users_save_path, 'w') { |file| file.write(to_write) }
    },
    load_session: lambda { |session|
      users_save_path = USER[:user_data_path].call(session.username)
      begin
        return JSON.parse(File.read(users_save_path), { symbolize_names: true })
      rescue JSON::ParserError
        puts 'Save file appears corrupted, trying to reset it.'
        $stdin.gets
        File.open("../cache/local_saves/#{session.username}.json", 'w+') { |f| f.write('{"Vocab":[]}') }
        users_save_path = USER[:user_data_path].call(session.username)
      end
    },
    # @ purpose merge session vocab with saved vocab
    # @return Returns hash of unique K, V pairs
    get_diff_vocab: lambda { |session, file_path|
      hash = JSON.parse(File.read(file_path))

      return nil if hash[:Vocab].is_a? NilClass

      hash = hash[:Vocab].each do |item|
        item if session.vocab[:Vocab].key? key
      end

      return hash
    }
  }.freeze
end


