class CurrentWeatherDetail
  attr_reader :id,
              :icon,
              :description,
              :today,
              :tonight,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index,
              :uv_category

  def initialize(data_current, data_daily)
    @id = nil
    @icon = data_current[:icon]
    @description = data_current[:summary]
    @today = data_daily[:data][0][:summary]
    @tonight = data_daily[:data][1][:summary]
    @feels_like = data_current[:apparentTemperature].round(0)
    @humidity = (data_current[:humidity] * 100).round(0).to_s + '%'
    @visibility = data_current[:visibility]
    @uv_index = data_current[:uvIndex]
    @uv_category = uv_category(data_current[:uvIndex])
  end

  def uv_category(uv_index)
    case uv_index
      when 0..2
        '(low)'
      when 3..5
        '(moderate)'
      when 6..7
        '(high)'
      when 8..10
        '(very high)'
      when 11..Float::INFINITY
        '(extreme)'
      else
        '(not valid)'
    end
  end
end
