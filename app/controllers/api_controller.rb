# frozen_string_literal: true
require 'uri'
require 'net/http'



# Handles API Calls
module Api
  @token = ENV['TOKEN']
  attr_reader :token
  #
  def self.lookup_word(word)
    url = URI("https://api.pons.com/v1/dictionary?q=dog&l=enfr")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-Secret"] = @token
    res = http.request(request)
    if res.is_a? Net::HTTPSuccess
      puts 'hello'
      gets
      File.open("./json_dump.json", "w") { |f| f.puts(res.body) }
      res = JSON.parse(res.body, { symbolize_names: true })
    end
  end
end


#  lookup_root = res[0][:hits][0][:roms][0]
#     lookup_word = lookup_root[:headword]
#
#     # puts "--- #{lookup_root}"
#     puts "Original word: #{lookup_word}"
#     definitions = lookup_root[:arabs]
#
#     definitions.each_with_index do |definition, index|
#       if definitions.size - 1 != index
#         print "#{index}:  #{definition[:header].scan(/[a-zA-Z]+/)[0]}     Translation: "
#         print definition[:translations].each { |translation| puts translation[:target].scan(/[a-zA-Z]+/)[0] }