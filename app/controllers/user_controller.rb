# frozen_string_literal: true
require 'passwordmasker'
# DOCUMENTATION:
# @description: Handles User Session Data
class User
  attr_reader :name

  def initialize(name, password)
    @name = name
    @password = password
  end

end