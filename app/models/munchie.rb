class Munchie
  attr_reader :id, :end_location, :travel_time, :forecast, :restaurant

  def initialize(end_location, travel_time, forecast, restaurant)
    @id = nil
    @end_location = end_location
    @travel_time = travel_time
    @forecast = forecast
    @restaurant = restaurant
  end
end
