class ForecastDaily
  attr_reader :icon,
              :summary,
              :precip_type,
              :precip_probability,
              :temp_avg,
              :temp_low,
              :temp_high,
              :humidity,
              :weekday

  def initialize(daily_data)
    @icon = daily_data[:icon]
    @summary = daily_data[:summary]
    @precip_type = daily_data[:precip_type]
    @precip_probability = daily_data[:precip_probability] * 100).round(0).to_s + '%'
    @temp_avg = ((data_daily[:temperatureHigh] + data_daily[:temperatureLow]) / 2).round(0)
    @temp_low = (data_daily[:temperatureLow]).round(0)
    @temp_high = (data_daily[:temperatureHigh]).round(0)
    @humidity = (data_daily[:humidity] * 100).round(0).to_s + '%'
    @weekday = Time.at(data_daily[:time]).strftime('%A')
  end
end
