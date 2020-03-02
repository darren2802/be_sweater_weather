class YelpService
  def self.restaurant(location, term, category, open_at)
    new.restaurant(location, term, category, open_at)
  end

  def restaurant(location, term, category, open_at)
    json = get_json('businesses/search', location, term, category, open_at)
  end

  private

    def get_json(uri, location, term, category, open_at)
      response = conn.get(uri) do |req|
        req.params['term'] = term
        req.params['categories'] = category
        req.params['location'] = location
        req.params['open_at'] = open_at
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(
        url: 'https://api.yelp.com/v3',
        headers: { 'Authorization' => "Bearer #{ENV['YELP_API_KEY']}" }
      )
    end
end
