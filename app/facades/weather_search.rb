class WeatherSearch
  attr_reader :id

  def initialize(location)
    @id = nil
    @geocode = GoogleMapsService.geocode(location)
    coordinates = @geocode[:geometry][:location]
    @weather_data = DarkSkyService.weather_info(coordinates)
  end

  def current_weather_summary
    CurrentWeatherSummary.new(
      @weather_data[:currently],
      @weather_data[:daily][:data][0],
      @geocode
    )
  end

  def current_weather_detail
    CurrentWeatherDetail.new(
      @weather_data[:currently],
      @weather_data[:daily]
    )
  end

  def forecast_hourly
    forecast_hash = Hash.new()

    8.times do |i|
      hash_key = ('hour_' + (i + 1).to_s).to_sym
      hourly_data = @weather_data[:hourly][:data][i + 1]
      forecast_hash[hash_key] = ForecastHourly.new(hourly_data)
    end

    forecast_hash
  end

  def forecast_daily
    forecast_hash = Hash.new()

    7.times do |i|
      hash_key = ('day_' + (i + 1).to_s).to_sym
      daily_data = @weather_data[:daily][:data][i + 1]
      forecast_hash[hash_key] = ForecastDaily.new(daily_data)
    end

    forecast_hash
  end
end
