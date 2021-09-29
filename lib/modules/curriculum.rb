require_relative 'lesson'
# Documentation Needed
module Curriculum
  class << self
    include Utilities

    attr_reader :lessons

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
      @flashcard_lists = {}
      flashcards = Utilities.get_flashcard_links.each { |_| }
      flashcards = Utilities.load_json(flashcards)

      flashcards.each do |flashcard|
        new_flashcard = Flashcard.new(flashcard)
        @flashcards.push new_flashcard
      end
    end
  end
end

