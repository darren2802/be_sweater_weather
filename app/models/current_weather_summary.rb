class CurrentWeatherSummary
  attr_reader :icon,
              :description,
              :temp_current,
              :temp_hi,
              :temp_low,
              :city,
              :state,
              :country,
              :time,
              :date,
              :time_short

  def initialize(data_current, data_daily, geocode)
    @icon = data_current[:icon]
    @description = data_current[:summary]
    @temp_current = data_current[:temperature].round(0)
    @temp_hi = data_daily[:temperatureHigh].round(0)
    @temp_low = data_daily[:temperatureLow].round(0)
    @city = geocode_city(geocode[:address_components])
    @state = geocode_state(geocode[:address_components])
    @country = geocode_country(geocode[:address_components])
    @time = Time.now.strftime("%I:%M %p")
    @date = Time.now.strftime("%m/%d")
    @time_short = Time.now.strftime("%e %p")
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
end
