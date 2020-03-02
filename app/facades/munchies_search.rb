class MunchiesSearch
  def initialize(start_loc, end_loc, food)
    @start_loc = start_loc
    @end_loc = end_loc
    @food = food
  end

  def travel_time
    directions = GoogleMapsService.directions(@start_loc, @end_loc)

    travel_time = directions[:routes][0][:legs][0][:duration][:text]
    travel_seconds = directions[:routes][0][:legs][0][:duration][:value]


    travel_time
  end

  def information
    Munchie.new(@end_loc, travel_time)
  end
end
