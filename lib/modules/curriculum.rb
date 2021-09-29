require_relative 'lesson'
require_relative 'flashcard_module'
# Documentation Needed
module Curriculum
  class << self
    include Utilities

    attr_reader :lessons, :flashcard_lists

    def setup_lesson_info
      @lessons = []
      # Find locally stored lessons, return path > load json using path data
      lessons = Utilities.get_lesson_links.each { |_| }
      lessons = Utilities.load_json(lessons)

      lessons.each do |lesson|
        new_lesson = Lesson.new(lesson)
        @lessons.push new_lesson
      end
    end

    def setup_flashcard_lists
      @flashcard_lists = []
      file_paths = Utilities.get_flashcard_links.each { |_| }
      flashcard_lists = Utilities.load_json(file_paths)
      # flashcard_lists = file_paths[:Content]

      flashcard_lists.each do |flash_list|
        new_flashcard = FlashcardModule.new(flash_list)
        @flashcard_lists.push new_flashcard
      end
    end
  end
end

