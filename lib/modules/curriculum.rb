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
  end
end

