require 'sinatra'
require 'json'
require 'base64'
require 'httparty'
require 'mongoid'
require 'geokit'
require_relative './models/stations'

# Configuration Sharing Web Service
class UbikeApi < Sinatra::Base
  Mongoid.load! "mongoid.yml"
  # station = Station.new(name: 'test',number: 123)
  # station.save
  # before do
  #   Configuration.setup
  # end
  before do
    content_type 'application/json'
  end


  get '/?' do
    'UbikeApi web service is up and running at /api/v1'
  end

  get '/v1/ubike-station/init' do
    station_arr = []
    response = HTTParty.get('http://data.taipei/youbike')
    stationInfos = JSON.parse(response)["retVal"]
    stationInfos.each do |station|
      # print "#{station[1]}\n"
      # Station.new(:name => station[1]["sna"],:sno => station[1]["sno"]).save
      station_arr.push({
        name:station[1]["sna"],
        sno:station[1]["sno"],
        tot:station[1]["tot"].to_i,
        sbi:station[1]["sbi"].to_i,
        lat:station[1]["lat"].to_f,
        lng:station[1]["lng"].to_f,
        mday:station[1]["mday"].to_i
        })
    end
    Station.create(station_arr)
    "ok"
  end

  get '/v1/ubike-station/taipei' do
    user_lan = params['lan'].to_f
    user_lng = params['lng'].to_f
    station_arr = []
    sorted_h = {}
    # response = HTTParty.get('http://data.taipei/youbike')
    # stationInfos = JSON.parse(response)["retVal"]
    Station.each do |station|
        start = Geokit::LatLng.new(user_lan,user_lng)
        distination = Geokit::LatLng.new(station["lat"],station["lng"])
        distance = start.distance_to(distination)
        # sorted_h[station["sno"]] = {"distance":distance,"num_ubike":station["sbi"],"station":station["name"]}
        station_arr.push({"distance":distance,"num_ubike":station["sbi"],"station":station["name"]})
    end
    station_arr = station_arr.sort_by{|value| value[:distance]}

    body = {
      "code":0,
      "result":station_arr[0..1]
    }
    body.to_json
  end

  get '/v1/ubike-station/update' do
    station_arr = []
    sorted_h = {}
    response = HTTParty.get('http://data.taipei/youbike')
    stationInfos = JSON.parse(response)["retVal"]
    batch = [{name:"test1",sbi:10,"tot":20,"lat":25,"lng":100,"mday":12345},{name:"test1",sbi:10,"tot":20,"lat":25,"lng":100,"mday":12345}]
    Station.create(batch)
    # Station.each do |station|
    #   target_sta = stationInfos[station["sno"]]
    #   if station["sbi"] != target_sta["sbi"]
    #     station["sbi"] = target_sta["sbi"]
    #     station["updatetime"] = target_sta["updatetime"]
    #     station.save
    #   end
    # end


    # stationInfos.each do |station|
    #   target_sta = Station.find_by(sno:station[1]["sno"].to_i)
    #   print target_sta
    #   if target_sta["sbi"] != station[1]["sbi"]
    #     target_sta["sbi"] = station[1]["sbi"].to_i
    #     target_sta["updatetime"] = Time.now.to_i
    #     target_sta.save
    #   end
    # end
    'ok'
  end
end
