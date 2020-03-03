class DarkSkyService
  def self.weather_info(coordinates)
    new.weather_info(coordinates)
  end

  def weather_info(coordinates)
    lat = coordinates[:lat]
    lng = coordinates[:lng]
    uri = "#{lat},#{lng}"

    get_json(uri)
  end

  def self.time_machine_forecast(coordinates, future_time)
    new.time_machine_forecast(coordinates, future_time)
  end

  def time_machine_forecast(coordinates, future_time)
    lat = coordinates[:lat]
    lng = coordinates[:lng]
    uri = "#{lat},#{lng},#{future_time}"

    get_json(uri)
  end

  private

    def get_json(uri)
      response = conn.get(uri) { |req| req.params['exclude'] = 'minutely' }

      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(
        url: "https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}"
      )
    end
end
