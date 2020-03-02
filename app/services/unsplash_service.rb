class UnsplashService
  def self.image_full(location)
    new.image_full(location)
  end

  def image_full(location)
    json = get_json('search/photos', location)
  end

  private

    def get_json(uri, parameters)
      response = conn.get('search/photos') do |req|
        req.params['query'] = parameters
        req.params['orientation'] = 'landscape'
        req.params['per_page'] = 1
      end

      json = JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(
        url: 'https://api.unsplash.com',
        headers: { 'Authorization': "Client-ID #{ENV['UNSPLASH_CLIENT_ID']}"}
      )
    end
end
