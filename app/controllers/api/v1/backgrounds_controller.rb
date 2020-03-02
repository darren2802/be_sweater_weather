class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]
    image_search = ImageSearch.new(location)
    render json: ImageSerializer.new(image_search.image_full_url)
  end
end
