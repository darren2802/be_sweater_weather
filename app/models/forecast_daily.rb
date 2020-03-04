class ForecastDaily
  attr_reader :id,
              :icon,
              :summary,
              :precip_type,
              :precip_probability,
              :temp_avg,
              :temp_low,
              :temp_high,
              :humidity,
              :weekday

  def initialize(daily_data)
    @id = nil
    @icon = daily_data[:icon]
    @summary = daily_data[:summary]
    @precip_type = daily_data[:precipType]
    @precip_probability = (daily_data[:precipProbability] * 100).round(0).to_s + '%'
    @temp_avg = ((daily_data[:temperatureHigh] + daily_data[:temperatureLow]) / 2).round(0)
    @temp_low = (daily_data[:temperatureLow]).round(0)
    @temp_high = (daily_data[:temperatureHigh]).round(0)
    @humidity = (daily_data[:humidity] * 100).round(0).to_s + '%'
    @weekday = Time.at(daily_data[:time]).strftime('%A')
  end
end
