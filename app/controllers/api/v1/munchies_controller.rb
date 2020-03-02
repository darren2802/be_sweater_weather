class Api::V1::MunchiesController < ApplicationController
  def show
    start_loc = params[:start]
    end_loc = params[:end]
    category = params[:food]

    munchies_search = MunchiesSearch.new(start_loc, end_loc, category)
    render json: MunchiesSerializer.new(munchies_search.information)
  end
end
