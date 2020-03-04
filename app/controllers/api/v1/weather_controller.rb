class Api::V1::WeatherController < ApplicationController
  def show
    location = params[:location]
    weather_search = WeatherSearch.new(location)
    render json: WeatherSerializer.new(weather_search)
  end
end
