require 'geokit'
require_relative '../models/stations'

class SortStation
  def self.return_body(lan,lng)
    station_arr = []
    Station.all.each do |station|
      if station["empty"] == true
        next
      end
      start = Geokit::LatLng.new(lan,lng)
      distination = Geokit::LatLng.new(station["lat"],station["lng"])
      distance = start.distance_to(distination)
      station_arr.push({
        "distance":distance,
        "num_ubike":station["sbi"],
        "station":station["name"],
        "full":station["full"]
        })
    end
    code = 0
    station_arr = station_arr.sort_by{|value| value[:distance]}[0..1]
    # print station_arr
    if station_arr[0]["full"] and station_arr[0]["full"]
      code = 1
    end

    station_arr.each do |station|
      station.delete :full
      station.delete :distance
    end

    body = {
      "code": code,
      "result": station_arr
    }
    body
  end
end
