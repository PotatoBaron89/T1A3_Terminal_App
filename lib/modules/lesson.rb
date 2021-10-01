require_relative '../classes/curriculum'
require_relative '../../app/controllers/content_controller'

# fr = session.vocab[':Vocab'].values.map { |word| word[0]['word'] }
# session.vocab[':Vocab'].values[0].map { |word| word['word']}
##{session.vocab[':Vocab'].values[0][0]['word'].join(' / ')}
##{session.vocab[':Vocab'].values[0]['word'].join(' / ')}
# def self.flash_card_menu(session, msg = "Select a list to study   Your known words: #{session.vocab[':Vocab'].length}")
# Documentation needed
class Lesson
  include Utilities

  attr_reader :title, :difficulty, :author, :updated, :modules, :desc, :section_titles, :section_descriptions,
              :file_ref, :sys, :_content_key

  # sets up basic meta information, not core content
  def initialize(json_file_path)
    @@_module_key = ENV['MODULE_KEY'].to_sym
    @@_content_key = ENV['CONTENT_KEY'].to_sym
    @@_lesson_key = ENV['LESSON_KEY'].to_sym
    @@_lesson_title_key = ENV['LESSON_TITLE_KEY'].to_sym
    @@_lesson_description = ENV['LESSON_DISCRIPTION'].to_sym


    hash = Utilities.load_json(json_file_path)
    descriptions = :Description
    mod = :Module


    super()
    @title = hash[mod][:Title]
    @difficulty = hash[mod][:Difficulty]

    @author = hash[mod][:Author]
    @updated = hash[mod][:Last_Updated]
    @desc = hash[mod][descriptions]
    @section_titles = []
    @section_descriptions = []
    @file_ref = json_file_path
    # alias to ContentController module
    @sys = ContentController


    hash[@@_content_key].each do |section|
      @section_titles.push section[@@_lesson_title_key] ||= []
      @section_descriptions.push section[@@_lesson_description] ||= []
    end
  end

  # Lesson classes are accessed from singleton 'Curriculum' in an array
  # WIP, currently just handles flashcards
  # Load the full lesson data
  def load_lesson(sect_index)
    hash = Utilities.load_json(@file_ref)

    vocab = hash[@@_content_key][sect_index][:Vocab]
    description = hash[@@_content_key][sect_index][:Description]
    questions = hash[@@_content_key][sect_index][:Sentences]
    word_info = sys::CACHE[:get_word_object].call(vocab)

    return [description, word_info, questions]
  end

end

