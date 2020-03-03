require 'rails_helper'

describe 'User can log in' do
  before :each do
    post '/api/v1/users', :params => {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    expect(response.status).to eq(201)
  end

  it 'creates a session for a user and returns the api_key if login successful' do
    post '/api/v1/sessions', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                            }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result.keys).to eq([:data])
    expect(result[:data].keys).to eq([:id, :type, :attributes])
    expect(result[:data][:attributes].keys).to eq([:api_key])
  end

  it 'returns an error message if login not successful due to invalid password' do
    post '/api/v1/sessions', :params => {
                              "email": "whatever@example.com",
                              "password": "assword",
                            }

    expect(response.status).to eq(400)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to eq({ message: "invalid credentials" })
  end

  it 'returns an error message if login not successful due to incorrect email' do
    post '/api/v1/sessions', :params => {
                              "email": "whateva@example.com",
                              "password": "password",
                            }

    expect(response.status).to eq(400)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to eq({ message: "invalid credentials" })
  end
end
