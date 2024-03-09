require 'thor'
require './zaim_connector'
require 'time'

class App < Thor
  desc "convert", "convert(type, start_at_text, end_at_text)"
  def convert(type, start_at_text, end_at_text = Time.now.to_s)
    zc = ZaimConnector.new(type:, start_at: Time.parse(start_at_text), end_at:Time.parse(end_at_text))
    zc.convert
  end
end

App.start(ARGV)