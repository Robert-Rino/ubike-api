require 'httparty'

class IsInTaipei
  def self.inTaipei(lat,lng)
    url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}&sensor=true"
    response = HTTParty.get(url)
    city = response["results"][0]["address_components"][-3]["long_name"].to_s
    city == "Taipei City" ? true : false
  end
end
