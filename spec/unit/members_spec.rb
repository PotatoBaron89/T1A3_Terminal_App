# frozen_string_literal: true
require_relative '../../lib/modules/members'
require 'rspec/autorun'

RSpec.describe Membership do
  it 'Handles checking if a user_exists' do
    expect(Membership::Utils.user_exists?('testaccount')).to eq(true)
  end

  it 'Handles checking if a user_exists' do
    expect(Membership.authenticate_user('test', '12345678', Utilities.user_db_get)).to eq(true)
  end
end
