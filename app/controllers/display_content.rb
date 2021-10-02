
module DisplayMenus
  ##
  # @Purpose: Render Information related to Lessons
  #
  # @param index Needs index of the Lesson to load
  # @param session requires current session data
  #
  # @return None
  def self.lesson_info(index, session)
    system 'clear'
    # Temporarily cache needed data
    lesson_card = Curriculum.lessons[index]

    # Output Header
    puts ['Title       '.colorize(:blue), " #{lesson_card.desc}".colorize(:red)]
           .columnize :displaywidth => 125, :colsep => ' | '
    print ['Difficulty  '.colorize(:blue), " #{lesson_card.difficulty}"]
            .columnize :displaywidth => 125, :colsep => ' | '
    puts ['      Author   '.colorize(:blue), " #{lesson_card.author}"]
           .columnize :displaywidth => 125, :colsep => ' | '

    # Create Menu Options, Lists all submodules within the lesson
    TTY::Prompt.new.select('      --- Course Content ---'.colorize(:yellow)) do |menu|
      # Loop over each section of the lesson and print its title and description
      lesson_card.section_titles.each_with_index do |sect, i|
        menu.choice "#{sect}  |   #{lesson_card.section_descriptions[i]}", -> { flash_card_controller(index, i, session) }
      end
      menu.choice 'Back'.colorize(:blue), -> { main_menu(session) }
    end
  end

  # @Purpose Handles core logic of creating flashcards
  # @use Loops while active == true.  Loop can be broken based on user input.
  # @param index of lesson / flashcard module to load
  # @param sect_index index of section to load within that module
  # @param session session data
  # @param is_lesson, default true.
  # @info is_lesson is part of the study module, not finished, only available in development mode.
  # @return none
  def self.flash_card_controller(index, sect_index, session, is_lesson=true)
    system 'clear'

    active = true
    # Load Lesson Content, check if lesson or flashcard (note lesson currently only has flashcard component for now (in development))
    if is_lesson
      descriptions, word_info, questions = Curriculum.lessons[index].load_lesson(sect_index)
    else
      word_info = Curriculum.flashcard_lists[index].load_flashcard(sect_index)
    end

    while active
      system 'clear'
      # Get random word
      rand_index = Random.rand(word_info.length - 1)

      # Ensure random word isn't the same as the previous word (provided more than one word in list)
      unless word_info.length == 1
        rand_index = Random.rand(word_info.length - 1) until word_info[rand_index] != session.last_word
        session.last_word = word_info[rand_index]
      end

      # Add word to user vocab (method handles logic of duplication), then save.
      Session::USER[:word_add_to_vocab].call(session, word_info[rand_index])
      Session::USER[:save_session].call(session)

      # Display Flashcard, take response back based on user input whether to break loop
      active = DisplayMenus.prompt_flash_card(word_info[rand_index][:english], word_info[rand_index][:translation]
                                                                                 .join(' / '), session)
    end
  end

  ##
  # @Purpose: Renders flashcard
  # @param content = primary content to display, will appear in center of card
  # @param title, will appear at top left of frame
  # @param prev_word, will appear at top center
  #
  # @return TTY:Box object, can be rendered with puts / print
  def self.create_card(content, title, prev_word = '')
    box = TTY::Box.frame(width: 65, height: 10, align: :center, padding: 3, border: :thick,
                         title: {top_left: "═ #{title} ", top_center: "| #{prev_word} |", bottom_right: "|  Version: #{DisplayMenus.version}  |══" }) do
      content

    end
    return box
  end
end

