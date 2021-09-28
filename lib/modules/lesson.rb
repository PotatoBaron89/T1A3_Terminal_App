require_relative 'curriculum'
require_relative '../../app/controllers/content_controller'

# Documentation needed
class Lesson
  include Utilities

  attr_reader :raw, :title, :difficulty, :author, :updated, :modules, :desc, :section_titles, :section_descriptions,
              :file_ref, :sys, :title_debug

  # sets up basic meta information, not core content
  def initialize(json_file_path)
    hash = Utilities.load_json(json_file_path)
    descriptions = ":Description"
    mod = ":Module"


    super()
    @title = hash[mod][":Title"]
    @title_debug = hash[mod][":Title"]
    @difficulty = hash[mod][":Difficulty"]

    @author = hash[mod][":Author"]
    @updated = hash[mod][":Last Updated"]
    @desc = hash[mod][descriptions]
    @section_titles = []
    @section_descriptions = []
    @file_ref = json_file_path
    # alias to ContentController module
    @sys = ContentController


    hash[":Lessons"].each do |section|
      @section_titles.push section[":LessonTitle"] ||= []
      @section_descriptions.push section[descriptions] ||= []
    end
  end

  # Lesson classes are accessed from singleton 'Curriculum' in an array
  # WIP, currently just handles flashcards
  # Load the full lesson data
  def load_lesson(sect_index)
    lessons = ":Lessons"
    hash = Utilities.load_json(@file_ref)
    vocab = hash[lessons][sect_index][":Vocab"]
    description = hash[lessons][sect_index][":Description"]
    questions = hash[lessons][sect_index][":Sentences"]

    words_en = sys::CACHE[:words_en].call(vocab)
    french_words = sys::CACHE[:words_fr].call(vocab)

    return [description, words_en, french_words, questions]
  end

end

# puts hash[1][2][2]    # Sentences
