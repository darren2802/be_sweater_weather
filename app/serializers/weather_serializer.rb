class WeatherSerializer
  include FastJsonapi::ObjectSerializer

  attributes  :current_weather_summary,
              :current_weather_detail,
              :forecast_hourly,
              :forecast_daily
end
