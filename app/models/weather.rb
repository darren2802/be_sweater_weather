class Weather
  attr_reader :id, :current_weather_summary, :current_weather_detail, :forecast

  def initialize(current_weather_summary, current_weather_detail, forecast)
    @id = nil
    @current_weather_summary = current_weather_summary
    @current_weather_detail = current_weather_detail
    @forecast = forecast
  end
end
