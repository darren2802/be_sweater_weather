class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :image_full_url
end
