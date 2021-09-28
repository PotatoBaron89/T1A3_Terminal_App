# frozen_string_literal: true


# @title Session
#
# @tasks: Store use session info
# @tasks: Pull relevant information from DB (or pseudo db in our case)

class Session
  attr_reader :username
  attr_accessor :is_authenticated, :dev_mode, :vocab
  include Utilities

  def initialize(username, is_authenticated = false, dev: false)
    @username = username
    @display_name = username
    @is_authenticated = is_authenticated
    @dev_mode = true
    @vocab = {}
  end

  def self.vocab_key
    return ':Vocab'
  end

  def self.userinfo_key
    return ':User_info'
  end

  def change_display_name
    @display_name = DisplayController.prompt('Display Name: ')
  end

  # @description returns userinfo as a hash
  def request_userinfo
    content = { username: self.username,
                display_name: self.to_s }

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
        File.open("../cache/local_saves/#{username}.json", 'w+') { |f| f.write('{":Vocab":{}}') }
      end
    },
    user_data_path: ->(username) { return "../cache/local_saves/#{username}.json" },

    user_dir_path: -> { return '../cache/local_saves/' },

    word_add_to_vocab: lambda { |session, word|
      # Remember self.vocab_key returns an array, which we don't want (hence the [0])
      session.vocab[self.vocab_key].store(word.keys[0], word.values)
    },

    find_words_by_type: lambda { |session, type|
      # french_words[0].merge(a)

      # matches = []
      # session.vocab[":Vocab"].values.select do |word|
      #   if word[0]["type"] == type
      #     matches << word[0]
      #   end
      # end
      # return matches
    },

    save_session: lambda { |session|
      file_path = USER[:user_data_path].call(session.username)

      # Load Vocab, take words that aren't already stored in session
      USER[:get_diff_vocab] if File.exist?(file_path)
      hash = File.exist?(file_path) ? USER[:get_diff_vocab].call(session, file_path) : {}


      if hash.nil?
        to_write = JSON.generate(":Vocab": session.vocab[self.vocab_key])
      else
        to_write = hash[self.vocab_key].merge(session.vocab[self.vocab_key]) unless hash[self.vocab_key].is_a? NilClass
        to_write = hash[self.vocab_key] ? JSON.generate(to_write) : JSON.generate(":Vocab": to_write)
        # request_userinfo
      end

      File.open(file_path, 'w') { |file| file.write(to_write) }
    },
    load_session: lambda { |session|
      file_path = USER[:user_data_path].call(session.username)
      return JSON.parse(File.read(file_path))
    },
    # @return Returns hash of unique K, V pairs
    get_diff_vocab: lambda { |session, file_path|
      hash = JSON.parse(File.read(file_path))

      return nil if hash[:Vocab].is_a? NilClass

      hash = hash[:Vocab].each do |item|
        item if session.vocab[':Vocab'].key? key
      end

      return hash
    }
    #word_attempt_results: ->(session, result) { }

  }.freeze
end


