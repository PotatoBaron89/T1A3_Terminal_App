
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

                   TTY::Prompt.new.select('      --- Course Content ---'.colorize(:yellow)) do |menu|
                     # Loop over each section of the lesson and print its title and description
                     lesson_card.section_titles.each_with_index do |sect, i|
                       menu.choice "#{sect}" + "       #{lesson_card.section_descriptions[i]}".colorize(:light_green),
                                   -> { study_menu(session) }
                     end
                     menu.choice 'Back', -> { main_menu(session) }
                   end
                 }
  }.freeze
end

