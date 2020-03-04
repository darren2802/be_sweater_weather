class ForecastHourly
  attr_reader :id,
              :time_short,
              :icon,
              :temperature

  def initialize(hourly_data)
    @id = nil
    @time_short = Time.at(hourly_data[:time]).strftime('%l %p')
    @icon = hourly_data[:icon]
    @temperature = round_temp(hourly_data[:temperature])
  end

  def round_temp(temp)
    temp.round(0)
  end
end
