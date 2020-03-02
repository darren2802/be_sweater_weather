class ImageSearch
  def initialize(location)
    @location = location
  end

  def image_full_url
    image_results = UnsplashService.image_full(@location)

    Image.new(image_results[:results][0][:urls][:full])
  end
end
