# frozen_string_literal: true


# @title Session
#
# @tasks: Store use session info
# @tasks: Pull relevant information from DB (or pseudo db in our case)
class Session
  attr_reader :username
  attr_accessor :is_authenticated, :dev_mode, :vocab

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
      File.open("../cache/local_saves/#{username}.json", 'w+') unless File.exists?("../cache/local_saves/#{username}.json")
    },
    user_data_path: ->(username) { return "../cache/local_saves/#{username}.json" },
    user_dir_path: -> { return '../cache/local_saves/' },
    word_add_to_vocab: lambda { |session, word|
      session.vocab[word.keys[0]] = word.values
    },
    find_words_by_type: lambda { |session, type|
      file = File.open(USER[:user_data_path].call(session.username), 'r')
      content = JSON.parse(file, { symbolize_names: true } )
      file.close

      matches = []
      content[":Vocab"].select do |word|
        matches << word if word
      end
    },
    save_session: lambda { |session|
      json = JSON.pretty_generate(":Vocab": session.vocab)
      File.open(USER[:user_data_path].call(session.username), 'w') { |file| file.write(json) }
    }
    #word_attempt_results: ->(session, result) { }

  }.freeze
end


