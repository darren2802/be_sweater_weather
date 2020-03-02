require 'rails_helper'

describe 'Background request spec' do
  it 'returns the url of the requested location', :vcr do
    get '/api/v1/backgrounds?location=london'

    expect(response).to be_successful

    image_result = JSON.parse(response.body, symbolize_names: true)

    expect(image_result).to be_a Hash
    expect(image_result.keys).to eq([:data])
    expect(image_result[:data].keys).to eq([:id, :type, :attributes])
    expect(image_result[:data][:attributes].keys).to eq([:image_full_url])
  end
end
