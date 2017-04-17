require 'httparty'

class IsInTaipei
  def self.inTaipei(lan,lng)
    url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{lan},#{lng}&sensor=true"
    response = HTTParty.get(url)
    city = response["results"][0]["address_components"][-3]["long_name"].to_s
    print city
    city == "Taipei City" ? true : false
  end
end
