require 'rails_helper'

describe 'User with api key can plan road trip', :vcr do
  it 'returns travel time and destination forecast' do
    # register a user to get an api key
    post '/api/v1/users', :params => {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    expect(response.status).to eq(201)

    result = JSON.parse(response.body, symbolize_names: true)
    api_key = result[:data][:attributes][:api_key]

    post '/api/v1/road_trip', :params => {
                                "origin": "Denver,CO",
                                "destination": "Pueblo,CO",
                                "api_key": api_key
                              }

    expect(response).to be_successful
    expect(response.status).to eq(202)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result.keys).to eq([:data])
    expect(result[:data].keys).to eq([:id, :type, :attributes])
    expect(result[:data][:id]).to be_nil
    expect(result[:data][:attributes].keys).to eq([:origin, :destination, :travel_time, :arrival_forecast])
    expect(result[:data][:attributes][:arrival_forecast].keys).to eq([:temperature, :description])
  end
end
