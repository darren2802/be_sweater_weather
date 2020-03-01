class GoogleMapsService
  def coordinates(location)
    json = get_json('/maps/api/geocode/json', {
      address: location
      })
    json[0][:geometry][:location]
  end

  private

    def get_json(uri, parameters)
      response = conn.get(uri) do |req|
        req.params = req.params.merge(parameters)
      end

      JSON.parse(response.body, symbolize_names: true)[:results]
    end

    def conn
      Faraday.new(
        url: 'https://maps.googleapis.com',
        params: { key: ENV['GOOGLE_API_KEY'] }
      )
    end
end
