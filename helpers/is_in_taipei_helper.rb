require 'httparty'

class IsInTaipei
  def self.inTaipei(lan,lng)
    url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{lan},#{lng}&sensor=true"
    response = HTTParty.get(url)
    city = response["results"][1]["address_components"][0]["long_name"].to_s
    city == "Taipei" ? true : false
  end
end
