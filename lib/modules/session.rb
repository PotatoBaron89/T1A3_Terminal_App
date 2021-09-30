# frozen_string_literal: true


# @title Session
#
# @tasks: Store use session info
# @tasks: Pull relevant information from DB (or pseudo db in our case)

class Session
  attr_reader :username
  attr_accessor :is_authenticated, :dev_mode, :vocab, :devmode
  include Utilities

  def initialize(username, is_authenticated = false, dev: false)
    @username = username
    @display_name = username
    @is_authenticated = is_authenticated
    @dev_mode = false
    @vocab = []
  end



  def self.vocab_key
    return :Vocab
  end

  def self.userinfo_key
    return :User_info
  end

  def change_display_name
    @display_name = DisplayController.prompt('Display Name: ')
  end

  # @description returns userinfo as a hash
  def request_userinfo
    content = { username: username,
                display_name: to_s }

    to_write = JSON.generate("#{Session.userinfo_key}": content)
    to_write = JSON.parse(to_write)
  end

  def to_s
    @display_name
  end

  def sign_out
    DisplayController.print_message(['You have successfully signed out.'])
    @is_authenticated = false
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
      session.vocab[vocab_key].push(word)
    },

    save_session: lambda { |session|
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
      return JSON.parse(File.read(users_save_path), { symbolize_names: true })
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


