require_relative 'lesson'
require_relative 'flashcard_content'
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

      # Loop over each found file
      lessons.each do |lesson|
        hash = Utilities.load_json(lesson)
        # Prevent Files with clearly incorrect structure
        if hash[:Module][:Title] && hash[:Content][0][:Vocab]
          new_lesson = Lesson.new(lesson)
          @lessons.push new_lesson
        end
      end
    end

    def setup_flashcard_lists
      @flashcard_lists = []
      file_paths = Utilities.get_flashcard_links.each { |_| }
      flashcard_lists = Utilities.load_json(file_paths)

      flashcard_lists.each do |flash_list|
        new_flashcard = FlashcardContent.new(flash_list)
        @flashcard_lists.push new_flashcard
      end
    end
  end
end

