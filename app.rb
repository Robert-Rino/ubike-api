require 'sinatra'
require 'json'
require 'base64'
require 'httparty'
require 'geokit'

# Configuration Sharing Web Service
class UbikeApi < Sinatra::Base
  enable :logging

  get '/?' do
    response = {"response"=>"UbikeApi web service is up and running at /api/v1"}.to_json
    [200,{'Content-Type' => 'application/json'},response]
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
        mday:station[1]["mday"].to_i,
        full: station[1]["tot"] == station[1]["sbi"] ? true : false,
        empty: station[1]["sbi"].to_i == 0 ? true : false
        })
    end
    Station.delete_all
    Station.create(station_arr)
    "ok"
  end

  get '/v1/ubike-station/taipei' do
    content_type 'application/json'

    begin
      user_lat = params['lat'].to_f
      user_lng = params['lng'].to_f

      if (user_lat.abs > 90) or (user_lng.abs > 180)
        body = {
          "code":-1,
          "result":[]
        }
        halt 400, body.to_json
      end

      if !IsInTaipei.inTaipei(user_lat,user_lng)
        body = {
          "code":-2,
          "result":[]
        }
        halt 400, body.to_json
      end

      body = SortStation.return_body(user_lat,user_lng)
      [200,body.to_json]

    rescue => e
      logger.info "FAILED to process '/v1/ubike-station/taipei': #{e.inspect}"
      halt 400, {
        "code":-3,
        "result":[]
      }.to_json
    end
  end
end
