class Image
  attr_reader :id, :image_full_url

  def initialize(image_full_url)
    @id = nil
    @image_full_url = image_full_url
  end
end
