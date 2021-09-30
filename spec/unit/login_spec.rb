# frozen_string_literal: true
require_relative '../../lib/modules/members'
require 'rspec/autorun'

RSpec.describe Membership do
  it 'It allows a user to log in' do
    mock = Membership.login('Sam','12345678')
    binding.irb
    expect(mock.is_authenticated).to eq(true)
    puts mock
  end

  it 'Prevents invalid login attempts' do
    expect(Membership.authenticate_user('user', 'useruser')).to be_falsey
  end

  it 'Test test' do
    expect(Membership.test).to eq(true)
  end

  it 'Test test' do
    mock = Utilities.salt_data('hello')
    expect(Membership.verify_hash_digest('hello') == mock).to eq(true)
  end
end
