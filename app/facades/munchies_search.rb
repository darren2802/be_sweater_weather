class MunchiesSearch
  def initialize(start_loc, end_loc, category)
    @start_loc = start_loc
    @end_loc = end_loc
    @category = category
    @travel_seconds = 0
    @arrival_time_unix = 0
  end

  def travel_time
    directions = GoogleMapsService.directions(@start_loc, @end_loc)
    @travel_seconds = directions[:routes][0][:legs][0][:duration][:value]
    directions[:routes][0][:legs][0][:duration][:text]
  end

  def destination_forecast
    dest_geocode = GoogleMapsService.geocode(@end_loc)
    coordinates = dest_geocode[:geometry][:location]
    @arrival_time_unix = Time.now.to_i + @travel_seconds
    weather_data = DarkSkyService.time_machine_forecast(coordinates, @arrival_time_unix)
    weather_data[:currently][:summary]
  end

  def restaurant
    restaurants = YelpService.restaurant(@end_loc, 'food', @category, @arrival_time_unix)

    name = restaurants[:businesses][0][:name]
    address = restaurants[:businesses][0][:location][:display_address].join(', ')

    restaurant_hash = {
      name: name,
      address: address
    }
  end

  def information
    Munchie.new(@end_loc, travel_time, destination_forecast, restaurant)
  end
end
