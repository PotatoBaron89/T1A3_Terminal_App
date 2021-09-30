# frozen_string_literal: true
require_relative '../../lib/modules/session'
require_relative '../../lib/modules/utilities'
require 'rspec/autorun'
require 'rspec'

RSpec.describe Membership do
  it 'Returns a guest session' do
    mock = Session.new('Guest', false)
    expect(mock.is_authenticated).to eq(false)
  end
end