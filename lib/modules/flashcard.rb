require_relative 'curriculum'
require_relative '../../app/controllers/content_controller'

# Documentation needed
class Flashcard
  include Utilities

  attr_reader :title, :difficulty, :author, :updated, :modules, :desc, :section_titles, :section_descriptions,
              :file_ref, :sys, :title_debug

  # sets up basic meta information, not core content
  def initialize(json_file_path)
    hash = Utilities.load_json(json_file_path)
    mod = ':Module'

    super()
    @title = hash[mod][:Title]
    @author = hash[mod][:Author]
    @updated = hash[mod][:Last_Updated]

    @section_titles = []
    @file_ref = json_file_path
    # alias to ContentController module
    @sys = ContentController

    hash[':Vocab'].each do |section|
      @section_titles.push section.keys ||= []
    end
  end

  # Lesson classes are accessed from singleton 'Curriculum' in an array
  # WIP, currently just handles flashcards
  # Load the full lesson data
  def load_flashcard(sect_index)
    lessons = ':Lessons'
    hash = Utilities.load_json(@file_ref)
    vocab = hash[lessons][sect_index][':Vocab']
    description = hash[lessons][sect_index][':Description']
    questions = hash[lessons][sect_index][':Sentences']

    words_en = sys::CACHE[:words_en].call(vocab)
    french_words = sys::CACHE[:get_word_object].call(vocab)

    return [description, words_en, french_words, questions]
  end
end


