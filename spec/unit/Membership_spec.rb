# frozen_string_literal: true
require_relative '../../lib/modules/utilities'
require_relative '../../lib/modules/session'
require_relative '../../lib/modules/members'
require_relative '../spec_helper'
require 'rspec'

RSpec.describe Membership do
  it 'Returns a guest session' do
    mock = Session.new('Guest', false)
    expect(mock.is_authenticated).to eq(false)
  end

  it 'Returns an authenticated session' do
    mock = Session.new('Guest', true)
    expect(mock.is_authenticated).to eq(true)
  end

  it 'Matches salted passwords' do
    mock = Utilities.salt_data('Sam doesnt like tests')
    expect(Membership.verify_hash_digest(mock)).to eq('Sam doesnt like tests')
  end
end