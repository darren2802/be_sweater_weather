class RoadTripSearch
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @travel_seconds = 0
    @origin_formatted = ''
    @destination_formatted = ''
  end

  def travel_time
    geocode_origin = GoogleMapsService.geocode(@origin)
    coordinates_start = geocode_origin[:geometry][:location].values.join(',')
    geocode_destination = GoogleMapsService.geocode(@destination)
    coordinates_end = geocode_destination[:geometry][:location].values.join(',')
    directions = GoogleMapsService.directions(coordinates_start, coordinates_end)
  require "pry"; binding.pry
    @travel_seconds = directions[:routes][0][:legs][0][:duration][:value]
    directions[:routes][0][:legs][0][:duration][:text]
  end

  def arrival_forecast

  end

  def information
    RoadTrip.new(
      travel_time,
      arrival_forecast,
      @origin_formatted,
      @destination_formatted)
  end

  private

    def format_location(geocode)
      city = ''
      state = ''

      geocode[:address_components].each do |add|
        city = add[:short_name] if add[:types] == ["locality", "political"]
        state = add[:short_name] if add[:types] == ["administrative_area_level_1", "political"]
      end

      city + ', ' + state
    end
end
