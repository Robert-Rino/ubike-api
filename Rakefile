Dir.glob('./{config,models,helpers}/init.rb').each do |file|
  require file
end
require './app'
require 'rake/testtask'

puts "Environment: #{ENV['RACK_ENV'] || 'development'}"

task default: [:api_spec]

desc 'Tests API route'
Rake::TestTask.new(name=:api_spec) do |t|
t.pattern = 'specs/*_spec.rb'
end
