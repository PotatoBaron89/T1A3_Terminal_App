# frozen_string_literal: true
require_relative '../../lib/modules/utilities'
require_relative '../../lib/modules/session'
require_relative '../../lib/classes/curriculum'
require_relative '../../lib/modules/lesson'
require_relative '../../lib/classes/flashcard_content'
require_relative '../spec_helper'
require 'dotenv'
Dotenv.load('./config.env')
require 'rspec'

RSpec.describe Curriculum do
  it 'flashcard_lists To contain an array' do
    Curriculum.setup_flashcard_lists
    expect(Curriculum.flashcard_lists).to be_a_kind_of(Array)
  end
  it 'Array should contain class FlashcardContent (Class)' do
    Curriculum.setup_flashcard_lists
    expect(Curriculum.flashcard_lists[0]).to be_a_kind_of(FlashcardContent)
  end

  it 'lessons To contain an array' do
    Curriculum.setup_lesson_info
    expect(Curriculum.lessons).to be_a_kind_of(Array)
  end

  it 'lesson Array contains Lessons (Class)' do
    Curriculum.setup_lesson_info
    expect(Curriculum.lessons[0]).to be_a_kind_of(Lesson)
  end
end