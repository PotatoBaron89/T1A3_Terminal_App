# frozen_string_literal: true

begin
  require 'remedy'
rescue LoadError
  puts 'You appear to be missing dependencies. Try run:'
  puts '"bundle install"'.colorize(:yellow)
end

require_relative './interactions'

##
# @description Creates block of content that accepts custom input. Input defined by passed proc (see below)
# By default
#     q = quit, can be overriden  key == 'q'
#     enter = continue                     || key.to_s == 'control_m'
#     ` = binding.irb if devmode == true   || key.to_s == 'back_quote'
#
#
# @Usage How to use
# Call .listen(header_content, content, footer_content, devmode?,  &block)
# All blocks are optional, devmode = false by default
#
# @param: header_content, accepts single line strings
# @param: content, array of strings should work (untested)
# @param: footer_content, accepts array of strings
# @param: devmode, accepts boolean
# @param: accepts procs, for allowing custom conditionals
# @example:  exit if %w[c q].include?(key.to_s)
# @example:  if key.to_s == 'h'
#              print 'hello '
#              puts 'world'
#             end
# @credit heavily customized version of acook's https://github.com/acook/remedy/blob/cf5d3b698a3b75bb249be09f29402ae526ef6f2d/lib/remedy/interaction.rb#L26
class ListenerContent
  include Remedy

  @_devmode = ENV['DEVMODE']
  attr_reader :_devmode

  def initialize
    @viewport = Viewport.new
  end

  def display_and_listen(header_content, content = " ", footer_content = " ", devmode = @_devmode, &block)
    ANSI.command.clear_screen!
    ANSI.screen.safe_reset!
    ANSI.cursor.home!

    interaction = Interaction.new
    draw(header_content, content, footer_content)

    interaction.loop do |key|
      @last_key = key
      interaction.quit! if key == 'q'
      break if key.to_s == 'control_m'
      interaction.debug! if key.to_s == 'back_quote' && devmode == true
      yield block.call(key) if block_given?
      draw(header_content, content, footer_content)
    end
  end

  def only_listen(session = nil, &block)
    interaction = Interaction.new
    @last_key = interaction.get_key
    # continue is to find out if the option is one that means we want to leave loop early
    true

    interaction.quit! if @last_key == 'q'
    return block.call(@last_key, session) if block_given?
  end

  # Renders header and footer, cannot change core content for now
  # String input must not be '' or crash!
  def draw(header_content = ' ', content = ' ', footer_content = ' ')
    @viewport.draw content(content), Size([0,0]), header(header_content), footer(footer_content)
  end

  def content(content)
    # this creates a new content every time we draw
    c = Content.new
    c << <<-CONTENT
#{content}
    CONTENT
    c
  end

  def header(msg = '')
    Header.new << msg
  end

  # footers are displayed the bottom of the viewport
  def footer(content = "You pressed: #{@last_key}")

    # Footer.new << "You pressed: #{@last_key}"
    Footer.new << content + "You pressed: #{@last_key}"
  end
end