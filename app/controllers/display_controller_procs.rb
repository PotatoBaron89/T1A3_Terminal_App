require 'strings'
# Documentation Needed
module DisplayController
  def self.flash_card_controller(index, sect_index, session)
    system 'clear'

    # Load Lesson Content
    descriptions, words_en, french_words, questions = Curriculum.lessons[index].load_lesson(sect_index)
    # a = Session::USER[:find_words_by_type].call(session, ":adj :desc")

    active = true

    while active
      system 'clear'
      # Get Random Word From List
      rand_index = Random.rand(words_en.length - 1)
      type = french_words[rand_index][:type]
      # additional = Session::USER[:find_words_by_type].call(session, type)

      # Store Word as Object and add to User Vocab List
      word = words_en[rand_index]

      word = { "#{word}": french_words[rand_index] }
      Session::USER[:word_add_to_vocab].call(session, word)
      Session::USER[:save_session].call(session)

      DisplayController.prompt_flash_card(words_en[rand_index], french_words[rand_index][:word].join(' / '))
    end
  end

  DISPLAY = {
    lesson_info: lambda { |index, session|
                   system 'clear'
                   lesson_card = Curriculum.lessons[index]
                   puts ['Title       '.colorize(:blue), " #{lesson_card.title}".colorize(:red)]
                          .columnize :displaywidth => 125, :colsep => ' | '

                   print ['Difficulty  '.colorize(:blue), " #{lesson_card.difficulty}"]
                          .columnize :displaywidth => 125, :colsep => ' | '

                   puts ['      Author   '.colorize(:blue), " #{lesson_card.author}"]
                          .columnize :displaywidth => 125, :colsep => ' | '

                   text = "#{lesson_card.desc}".colorize(:light_green)
                   puts Strings.wrap(text, 90)
                   puts
                   # Need to find a cleaner way of handling this.. it works but it's a mess
                   puts
                   TTY::Prompt.new.select('      --- Course Content ---'.colorize(:yellow)) do |menu|
                     # Loop over each section of the lesson and print its title and description
                     lesson_card.section_titles.each_with_index do |sect, i|
                       menu.choice "#{sect}" + "       #{lesson_card.section_descriptions[i]}".colorize(:light_green),
                                   # -> { DISPLAY[:flash_card_controller].call(index, i, session) }
                                   flash_card_controller(index, i, session)
                     end
                     menu.choice 'Back'.colorize(:blue), -> { main_menu(session) }
                   end
                 },
    flash_card_controller: lambda { |index, sect_index, session|
      system 'clear'

      a = Session::USER[:find_words_by_type].call(session, ":adj :desc")

      active = true
      # Load Lesson Content
      descriptions, words_en, french_words, questions = Curriculum.lessons[index].load_lesson(sect_index)

      while active
        system 'clear'
        # Get Random Word From List
        rand_index = Random.rand(words_en.length - 1)
        type = french_words[rand_index][:type]
        additional = Session::USER[:find_words_by_type].call(session, type)

        # Store Word as Object and add to User Vocab List
        word = words_en[rand_index]

        word = { "#{word}": french_words[rand_index] }
        Session::USER[:word_add_to_vocab].call(session, word)
        Session::USER[:save_session].call(session)

        DisplayController.prompt_flash_card(words_en[rand_index], french_words[rand_index][:word].join(' / '))
      end
    },
    # Returns a TTY:Box as the flashcard, with contents inside
    create_card: lambda { |content, title, prev_word=''|
                  box = TTY::Box.frame(width: 35, height: 10, align: :center, padding: 3, border: :thick,
                                       title: {top_left: "═ #{title} ", top_center: "| #{prev_word} |", bottom_right: "|  Version: #{DISPLAY[:version].call}  |══" }) do
                    content
                  end
                  return box
                },
    version: -> { return ENV['VERSION'] }
  }.freeze
end

