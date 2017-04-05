require 'sinatra'
require 'json'
require 'base64'
require 'HTTParty'
require_relative 'models/configuration'

# Configuration Sharing Web Service
class UbikeApi < Sinatra::Base
  before do
    Configuration.setup
  end

  get '/?' do
    'UbikeApi web service is up and running at /api/v1'
  end

  get '/v1/ubike-station/taipei' do
    user_lan = params['lan'].to_f
    user_lng = params['lng'].to_f
    station_arr = []
    sorted_h = {}
    response = HTTParty.get('http://data.taipei/youbike')
    stationInfos = JSON.parse(response)["retVal"]
    stationInfos.each do |station|
      station_arr.push(station[1])
      dx = (station[1]["lat"].to_f-user_lan).abs
      dy = (station[1]["lng"].to_f-user_lng).abs
      distance = Math.sqrt((dx**2)+(dy**2))
      sorted_h[station[1]["sno"]] = distance
    end
    sorted_h = sorted_h.sort_by{|key,value| value}.to_s
  end
end
