class GoogleMapsService
  def self.geocode(location)
    new.geocode(location)
  end

  def geocode(location)
    json = get_json('/maps/api/geocode/json', {
      address: location
      })
    json[0]
  end

  def self.directions(origin, destination)
    new.directions(origin, destination)
  end

  def directions(origin, destination)
    json = get_json('/maps/api/directions/json', {
      origin: origin,
      destination: destination
      })
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
