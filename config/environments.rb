require 'sinatra'

configure :development, :test do
  require 'config_env'
  ConfigEnv.path_to_config("#{__dir__}/config_env.rb")
end

configure :production do
  # ENV['DATABASE_URL'] should be set by Heroku
  # Configuration settings should be directly set on Heroku
end

configure do
  require 'mongoid'
  Mongoid.load! "mongoid.yml"

end
