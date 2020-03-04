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
    @precip_probability = round_temp(daily_data[:precipProbability] * 100).to_s + '%'
    @temp_avg = round_temp((daily_data[:temperatureHigh] + daily_data[:temperatureLow]) / 2)
    @temp_low = round_temp(daily_data[:temperatureLow])
    @temp_high = round_temp(daily_data[:temperatureHigh])
    @humidity = round_temp(daily_data[:humidity] * 100).to_s + '%'
    @weekday = Time.at(daily_data[:time]).strftime('%A')
  end

  def round_temp(temp)
    temp.round(0)
  end
end
