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
    @is_authenticated = is_authenticated
    @dev_mode = true
    @vocab = {}
  end

  def to_s
    @username
  end

  def sign_out
    DisplayController.print_message(['You have successfully signed out.'])
    @is_authenticated = false
  end

  USER = {
    setup_user_cache: lambda { |username|
      puts "from user: #{username}"
      gets
      Dir.mkdir('../cache') unless File.exist?('../cache')
      Dir.mkdir(USER[:user_dir_path].call()) unless File.exist?('../cache/local_saves/')
      unless File.exists?("../cache/local_saves/#{username}.json")
        File.open("../cache/local_saves/#{username}.json", 'w+') { |f| f.write('{":Vocab":{}}') }
      end
    },
    user_data_path: ->(username) { return "../cache/local_saves/#{username}.json" },
    user_dir_path: -> { return '../cache/local_saves/' },
    word_add_to_vocab: lambda { |session, word|
      # Remember key returns an array, which we don't want (hence the [0])
      session.vocab[":Vocab"].store(word.keys[0], word.values)
    },
    find_words_by_type: lambda { |session, type|

      matches = []
      session.vocab.select do |word|

        if word["type"] == type
          matches << word
        end
      end
    },
    save_session: lambda { |session|
      key = ":Vocab"
      file_path = USER[:user_data_path].call(session.username)
      hash = JSON.parse(File.read(file_path)) if File.exist?(file_path)
      hash = hash[key].each { |_| }

      merged = hash.merge(session.vocab[key])
      merged = merged[key] ? JSON.generate(merged) : JSON.generate(":Vocab": merged)

      File.open(file_path, 'w') { |file| file.write(merged) }
    },
    load_session: lambda { |session|
      file_path = USER[:user_data_path].call(session.username)
      return JSON.parse(File.read(file_path))
    }
    #word_attempt_results: ->(session, result) { }

  }.freeze
end


