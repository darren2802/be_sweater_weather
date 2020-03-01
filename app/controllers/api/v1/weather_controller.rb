class Api::V1::WeatherController < ApplicationController
  def show
    require "pry"; binding.pry
    location = params[:id]
    render json WeatherSerializer.new(WeatherSearch.new(location))
  end
end
