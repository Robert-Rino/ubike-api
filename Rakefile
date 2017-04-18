require './app'
require 'rake/testtask'

puts "Environment: #{ENV['RACK_ENV'] || 'development'}"

task default: [:spec]

desc 'Tests API root route'
task :api_spec do
  sh 'ruby specs/api_spec.rb'
end

desc 'Run all the tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'specs/*_spec.rb'
  t.warning = false
end

desc 'Run init function'
task :init do
  sh 'ruby helper/init_helper.rb'
end
