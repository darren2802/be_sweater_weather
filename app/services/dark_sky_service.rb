class DarkSkyService
  def self.weather_info(coordinates)
    new.weather_info(coordinates)
  end

  def weather_info(coordinates)
    lat = coordinates[:lat]
    lng = coordinates[:lng]

    json = get_json(lat, lng)
  end

  def self.time_machine_forecast(coordinates, future_time)
    new.time_machine_forecast(coordinates, future_time)
  end

  def time_machine_forecast(coordinates, future_time)
    lat = coordinates[:lat]
    lng = coordinates[:lng]

    json = get_json(lat, lng, future_time)
  end

  private

  def get_json(lat, lng, time)
    url = "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{lat},#{lng},#{time}"

    response = Faraday.get(url) { |req| req.params['exclude'] = 'minutely' }

    JSON.parse(response.body, symbolize_names: true)
  end
end
