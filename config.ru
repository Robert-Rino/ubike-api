Dir.glob('./{config,models,helpers}/init.rb').each do |file|
  require file
end
require './app.rb'
run UbikeApi
