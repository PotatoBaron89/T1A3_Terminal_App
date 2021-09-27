require 'strings'
# Documentation Needed
module DisplayController
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
                                   -> { DISPLAY[:flash_card_controller].call(index, i, session) }
                     end
                     menu.choice 'Back'.colorize(:blue), -> { main_menu(session) }
                   end
                 },
    flash_card_controller: lambda { |index, sect_index, session|
      system 'clear'

      active = true
      while active
        system 'clear'
        descriptions, words_en, french_words, questions = Curriculum.lessons[index].load_lesson(sect_index)
        rand_index = Random.rand(words_en.length - 1)
        DisplayController.prompt_flash_card(words_en[rand_index], french_words[rand_index][:word].join(' / '))
      end
    },
    # Must be a cleaner way than to return this
    create_card: lambda { |content, title, prev_word=''|
                  box = TTY::Box.frame(width: 35, height: 10, align: :center, padding: 3, border: :thick,
                                       title: {top_left: title, top_center: " #{prev_word} " }) do
                    content
                  end
                  return box
                }
  }.freeze
end

