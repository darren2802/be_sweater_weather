class WeatherSerializer
  include FastJsonapi::ObjectSerializer

  attributes :current_summary, :current_detailed, :forecast
end
