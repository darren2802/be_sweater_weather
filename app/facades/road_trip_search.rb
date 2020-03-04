class RoadTripSearch
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @travel_seconds = 0
    @origin_formatted = ''
    @destination_formatted = ''
    @geocode_destination = ''
  end

  def travel_time
    geocode_origin = GoogleMapsService.geocode(@origin)
    @origin_formatted = format_location(geocode_origin)
    coordinates_start = geocode_origin[:geometry][:location].values.join(',')
    @geocode_destination = GoogleMapsService.geocode(@destination)
    @destination_formatted = format_location(@geocode_destination)
    coordinates_end = @geocode_destination[:geometry][:location].values.join(',')
    directions = GoogleMapsService.directions(coordinates_start, coordinates_end)
    @travel_seconds = directions[:routes][0][:legs][0][:duration][:value]
    directions[:routes][0][:legs][0][:duration][:text]
  end

  def arrival_forecast
    coordinates = @geocode_destination[:geometry][:location]
    arrival_time_unix = Time.now.to_i + @travel_seconds
    weather_data = DarkSkyService.time_machine_forecast(coordinates, arrival_time_unix)

    arrival_forecast_hash = {
      temperature: weather_data[:currently][:temperature].round(0),
      description: weather_data[:currently][:summary]
    }
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
