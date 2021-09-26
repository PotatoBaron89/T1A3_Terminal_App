require_relative 'curriculum'
require_relative '../../app/controllers/content_controller'

# Documentation needed
class Lesson
  include Utilities

  attr_reader :raw, :title, :difficulty, :author, :updated, :modules, :desc, :section_titles, :section_descriptions,
              :file_ref, :sys

  # sets up basic meta information, not core content
  def initialize(json)
    hash = Utilities.load_json(json)
    super()
    @title = hash[0]['Module']
    @difficulty = hash[0]['Difficulty']
    @author = hash[0]['Author']
    @updated = hash[0]['Last Updated']
    @desc = hash[0]['Description']
    @section_titles = []
    @section_descriptions = []
    @file_ref = json
    @sys = ContentController

    hash[1].each do |section|
      @section_titles.push section[0]['Section Info']['Title'] ||= []
      @section_descriptions.push section[0]['Section Info']['Description'] ||= []
    end
  end

  # Lesson classes are accessed from singleton 'Curriculum' in an array
  # WIP, currently just handles flashcards
  # Load the full lesson data
  def load_lesson(sect_index)
    hash = Utilities.load_json(@file_ref)
    vocab = hash[1][sect_index][1]

    questions = hash[1][sect_index][2]
    description = hash[1][sect_index][0]
    words_en = sys::CACHE[:words_en].call(vocab)
    french_words = sys::CACHE[:words_fr].call(vocab)
    return [description, words_en, french_words, questions]
  end

end

# puts hash[1][2][2]    # Sentences
