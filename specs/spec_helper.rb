ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
Dir.glob('./{config,models,helpers}/init.rb').each do |file|
  require file
end
require_relative '../app'

include Rack::Test::Methods

def app
  UbikeApi
end
