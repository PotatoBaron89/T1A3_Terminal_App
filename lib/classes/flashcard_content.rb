require_relative 'curriculum'
require_relative '../../app/controllers/content_controller'

# Documentation needed
class FlashcardContent
  include Utilities

  attr_reader :module_title, :difficulty, :modules, :section_titles, :file_ref, :sys, :flashcard_count,
              :module_flashcard_count

  # sets up basic meta information, not core content
  def initialize(json_file_path)
    super()
    hash = Utilities.load_json(json_file_path)

    @module_title = hash[:Module][:Title]
    @file_ref = json_file_path
    @section_titles = []
    @module_flashcard_count = []
    @flashcard_count = 0
    # alias to ContentController module
    @sys = ContentController

    hash[:Content].each do |section|
      @section_titles.push section[:Title] ||= []
      @flashcard_count += section[:Vocab].length
      @module_flashcard_count.push section[:Vocab].length
    end
  end


  # Load Vocab from selected module
  def load_flashcard(sect_index)
    hash = Utilities.load_json(@file_ref)
    vocab = hash[:Content][sect_index][:Vocab]

    word_info = sys::CACHE[:get_word_object].call(vocab)
    return word_info
  end
end


