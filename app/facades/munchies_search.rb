class MunchiesSearch
  def initialize(start_loc, end_loc, category)
    @start_loc = start_loc
    @end_loc = end_loc
    @end_loc_formatted = ''
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
    format_end_loc(dest_geocode)
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
    Munchie.new(travel_time, destination_forecast, restaurant, @end_loc_formatted)
  end

  def format_end_loc(geocode)
    city = ''
    state = ''

    geocode[:address_components].each do |add|
      city = add[:short_name] if add[:types] == ["locality", "political"]
      state = add[:short_name] if add[:types] == ["administrative_area_level_1", "political"]
    end

    @end_loc_formatted = city + ', ' + state
  end
end
