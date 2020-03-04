require 'rails_helper'

describe 'User with api key can plan road trip', :vcr do
  before :each do
    post '/api/v1/users', :params => {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    expect(response.status).to eq(201)

    result = JSON.parse(response.body, symbolize_names: true)
    @api_key = result[:data][:attributes][:api_key]
  end

  it 'returns travel time and destination forecast if valid api key' do
    post '/api/v1/road_trip', :params => {
                                "origin": "Denver,CO",
                                "destination": "Pueblo,CO",
                                "api_key": @api_key
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

  it 'returns an error message if no api key' do
    post '/api/v1/road_trip', :params => {
                                "origin": "Denver,CO",
                                "destination": "Pueblo,CO",
                                "api_key": ''
                              }

    expect(response.status).to eq(401)
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to eq({ message: "invalid request" })
  end

  it 'returns an error message if invalid api key' do
    post '/api/v1/road_trip', :params => {
                                "origin": "Denver,CO",
                                "destination": "Pueblo,CO",
                                "api_key": 'd3+QvCZ3zz0yNtvTAAbk5mSEpYuP'
                              }

    expect(response.status).to eq(401)
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to eq({ message: "invalid request" })
  end
end
