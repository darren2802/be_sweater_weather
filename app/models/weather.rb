class Weather
  attr_reader @current_weather_summary, @current_weather_detail, @forecast

  def initialize(current_weather_summary, current_weather_detail, forecast)
    @current_weather_summary = current_weather_summary
    @current_weather_detail = current_weather_detail
    @forecast = forecast
  end
end
