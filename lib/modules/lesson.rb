require_relative 'curriculum'

# Documentation needed
class Lesson
  include Utilities
  attr_reader :raw, :title, :difficulty, :author, :updated, :modules, :desc, :section_titles, :section_descriptions

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

    hash[1].each do |section|
      @section_titles.push section[0]['Section Info']['Title'] ||= []
      @section_descriptions.push section[0]['Section Info']['Description'] ||= []
    end
  end
end
