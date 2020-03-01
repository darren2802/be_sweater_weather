class WeatherSearch
  def initialize(location)
    @location = location
  end

  def lat_long(location)
    GoogleMapsService.coordinates(location)
  end

  def weather_info(coordinates)
    DarkSkyService.weather_info(coordinates)
  end
end
