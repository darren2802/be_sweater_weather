class Api::V1::BackgroundsController < ApplicationController
  def show
    conn = Faraday.new(
      url: 'https://api.unsplash.com',
      headers: { 'Authorization' => "Client-ID #{ENV['UNSPLASH_CLIENT_ID']}"}
    )

    response = Faraday.get('https://api.unsplash.com/search/photos') do |req|
      req.params['query'] = params[:location]
      req.params['orientation'] = 'landscape'
      req.params['per_page'] = 1
    end

    require "pry"; binding.pry
  end
end
