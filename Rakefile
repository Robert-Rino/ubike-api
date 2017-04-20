require './app'
require 'rake/testtask'

puts "Environment: #{ENV['RACK_ENV'] || 'development'}"

task default: [:api_spec]

desc 'Tests API route'
task :api_spec do
  sh 'ruby specs/api_spec.rb'
end
