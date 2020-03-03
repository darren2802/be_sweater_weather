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
  end
end
