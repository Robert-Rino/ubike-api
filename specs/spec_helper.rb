ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require_relative '../helpers/init'
require_relative '../app'

include Rack::Test::Methods

def app
  UbikeApi
end
