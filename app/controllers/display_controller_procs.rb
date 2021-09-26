
# Documentation Needed
module DisplayController
  DISPLAY = {
    lesson_info: lambda { |index, session|
                   system 'clear'
                   lesson_card = Curriculum.lessons[index]
                   puts "Title: #{lesson_card.title}".colorize(:yellow)
                   puts "Difficulty:".colorize(:blue) + " #{lesson_card.difficulty}"
                   puts "Author:".colorize(:blue) + " #{lesson_card.author}"
                   puts
                   puts "Description:".colorize(:blue) + " #{lesson_card.desc}".colorize(:light_green)

                   # Need to find a cleaner way of handling this.. it works but it's a mess
                   TTY::Prompt.new.select('      --- Course Content ---'.colorize(:yellow)) do |menu|
                     # Loop over each section of the lesson and print its title and description
                     lesson_card.section_titles.each_with_index do |sect, i|
                       menu.choice "#{sect}" + "       #{lesson_card.section_descriptions[i]}".colorize(:light_green),
                                   -> { DISPLAY[:flash_card_controller].call(index, i, session) }
                     end
                     menu.choice 'Back', -> { main_menu(session) }
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

    }
  }.freeze
end

