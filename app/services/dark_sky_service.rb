class DarkSkyService
  def self.weather_info(coordinates)
    new.weather_info(coordinates)
  end

  def weather_info(coordinates)
    lat = coordinates[:lat]
    lng = coordinates[:lng]

    json = get_json(lat, lng)
  end

  private

    def get_json(lat, lng)
      url = "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{lat},#{lng}"

      response = Faraday.get(url) { |req| req.params['exclude'] = 'minutely' }

      JSON.parse(response.body, symbolize_names: true)
    end
end
