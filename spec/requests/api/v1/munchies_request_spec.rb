require 'rails_helper'

describe 'Munchies API' do
  it 'can retrieve food and forecast information for a destination city as well
      as travel time to that city', :vcr do

    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    expect(response).to be_successful

    munchies = JSON.parse(response.body, symbolize_names: true)

    expect(munchies).to be_a Hash
    expect(munchies.keys).to eq([:data])
    expect(munchies[:data].keys).to eq([:id, :type, :attributes])
    expect(munchies[:data][:id]).to be_nil
    expect(munchies[:data][:attributes].keys).to eq([:end_location, :travel_time, :forecast, :restaurant])
    expect(munchies[:data][:attributes][:restaurant].keys).to eq([:name, :address])
  end
end
