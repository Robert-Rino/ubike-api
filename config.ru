require './config/init.rb'
require './app.rb'
require 'rack/protection'
use Rack::Protection, :except => :json_csrf
run UbikeApi
