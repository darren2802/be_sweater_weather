class Munchie
  attr_reader :id, :end_location, :travel_time, :forecast, :restaurant

  def initialize(travel_time, forecast, restaurant, end_location)
    @id = nil
    @end_location = end_location
    @travel_time = travel_time
    @forecast = forecast
    @restaurant = restaurant
  end
end
