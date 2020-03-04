class Api::V1::RoadTripsController < ApplicationController
  def create
    origin = params[:origin]
    destination = params[:destination]
    api_key = params[:api_key]

    return render json: { message: 'invalid request' }, status: 401 unless User.find_by(api_key: api_key)

    road_trip_search = RoadTripSearch.new(origin, destination)
    render json: RoadTripSerializer.new(road_trip_search.information), status: 202
  end
end
