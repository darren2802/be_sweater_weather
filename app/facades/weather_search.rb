class WeatherSearch
  def initialize(location)
    @location = location
  end

  def geocode(location)
    GoogleMapsService.geocode(location)
  end

  def weather_info
    geocode = geocode(@location)
    coordinates = geocode[:geometry][:location]
    weather_data = DarkSkyService.weather_info(coordinates)
    current_summary = current_weather_summary(weather_data[:currently], weather_data[:daily][:data][0], geocode)
    current_detail = current_weather_detail(weather_data[:currently], weather_data[:daily])
    forecast = forecast(weather_data[:daily][:data])

    weather = Weather.new(current_summary, current_detail, forecast)
  end

  def current_weather_summary(data_current, data_daily, geocode)
    {
      icon: data_current[:icon],
      description: data_current[:summary],
      temp_current: data_current[:temperature].round(0),
      temp_hi: data_daily[:temperatureHigh].round(0),
      temp_low: data_daily[:temperatureLow].round(0),
      city: geocode_city(geocode[:address_components]),
      state: geocode_state(geocode[:address_components]),
      country: geocode_country(geocode[:address_components]),
      time: Time.now.strftime("%I:%M %p"),
      date: Time.now.strftime("%m/%d"),
      time_short: Time.now.strftime("%e %p")
    }
  end

  def geocode_city(address_components)
    address_components.each do |element|
      return element[:short_name] if element[:types] == ["locality", "political"]
    end
  end

  def geocode_state(address_components)
    address_components.each do |element|
      return element[:short_name] if element[:types] == ["administrative_area_level_1", "political"]
    end
  end

  def geocode_country(address_components)
    address_components.each do |element|
      return element[:long_name] if element[:types] == ["country", "political"]
    end
  end

  def current_weather_detail(data_current, data_daily)
    {
      icon: data_current[:icon],
      description: data_current[:summary],
      today: data_daily[:data][0][:summary],
      tonight: data_daily[:data][1][:summary],
      feels_like: data_current[:apparentTemperature].round(0),
      humidity: (data_current[:humidity] * 100).round(0).to_s + '%',
      visibility: data_current[:visibility],
      uv_index: data_current[:uvIndex],
      uv_category: uv_category(data_current[:uvIndex])
    }
  end

  def forecast(data_daily)
    forecast_hash = Hash.new

    7.times do |i|
      hash_key = ('day_' + (i + 1).to_s).to_sym
      forecast_hash[hash_key] = {
        icon: data_daily[i + 1][:icon],
        summary: data_daily[i + 1][:summary],
        precip_type: data_daily[i + 1][:precipType],
        precip_probability: (data_daily[i + 1][:precipProbability] * 100).round(0).to_s + '%',
        temp_avg: ((data_daily[i + 1][:temperatureHigh] + data_daily[i + 1][:temperatureLow]) / 2).round(0),
        temp_low: (data_daily[i + 1][:temperatureLow]).round(0),
        temp_high: (data_daily[i + 1][:temperatureHigh]).round(0),
        humidity: (data_daily[i + 1][:humidity] * 100).round(0).to_s + '%',
        weekday: Time.at(data_daily[i + 1][:time]).strftime('%A')
      }
    end

    forecast_hash
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
