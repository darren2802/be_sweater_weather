class ForecastHourly
  attr_reader :id,
              :time_short,
              :icon,
              :temperature

  def initialize(hourly_data)
    @id = nil
    @time_short = Time.at(hourly_data[:time]).strftime('%l %p')
    @icon = hourly_data[:icon]
    @temperature = hourly_data[:temperature]
  end
end
