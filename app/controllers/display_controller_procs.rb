require 'strings'
# Documentation Needed
module DisplayController

  # Needs Refactoring: Loads Meta information about each lesson and lists them for user selection
  def self.lesson_info(index, session)
    system 'clear'
    lesson_card = Curriculum.lessons[index]

    puts ['Title       '.colorize(:blue), " #{lesson_card.desc}".colorize(:red)]
           .columnize :displaywidth => 125, :colsep => ' | '
    print ['Difficulty  '.colorize(:blue), " #{lesson_card.difficulty}"]
            .columnize :displaywidth => 125, :colsep => ' | '
    puts ['      Author   '.colorize(:blue), " #{lesson_card.author}"]
           .columnize :displaywidth => 125, :colsep => ' | '

    TTY::Prompt.new.select('      --- Course Content ---'.colorize(:yellow)) do |menu|
      # Loop over each section of the lesson and print its title and description
      lesson_card.section_titles.each_with_index do |sect, i|
        menu.choice "#{sect}  |   #{lesson_card.section_descriptions[i]}", -> { flash_card_controller(index, i, session) }
      end
      menu.choice 'Back'.colorize(:blue), -> { main_menu(session) }
    end
  end


  def self.flash_card_controller(index, sect_index, session)
    system 'clear'
    # a = Session::USER[:find_words_by_type].call(session, ":adj :desc")

    active = true
    # Load Lesson Content
    descriptions, word_info, questions = Curriculum.lessons[index].load_lesson(sect_index)

    while active
      system 'clear'
      # Get Random Word From List
      rand_index = Random.rand(word_info.length - 1)
      type = word_info[rand_index][:type]
      # additional = Session::USER[:find_words_by_type].call(session, type)

      # Store Word as Object and add to User Vocab List

      Session::USER[:word_add_to_vocab].call(session, word_info[rand_index])
      Session::USER[:save_session].call(session)

      DisplayController.prompt_flash_card(word_info[rand_index][:english], word_info[rand_index][:translation].join(' / '), session)
    end
  end

  def self.create_card(content, title, prev_word = '')
    box = TTY::Box.frame(width: 65, height: 10, align: :center, padding: 3, border: :thick,
                         title: {top_left: "═ #{title} ", top_center: "| #{prev_word} |", bottom_right: "|  Version: #{DisplayController.version}  |══" }) do
      content

    end
    return box
  end

  def self.version
    return ENV['VERSION']
  end
end

