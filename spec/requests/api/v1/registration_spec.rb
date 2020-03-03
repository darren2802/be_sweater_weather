require 'rails_helper'

describe 'User can register spec' do
  it 'creates a user and returns an API key for a successful registration' do
    post '/api/v1/users', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                              "password_confirmation": "password"
                            }

    expect(response).to be_successful
    expect(response.status).to eq(201)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result.keys).to eq([:data])
    expect(result[:data][:attributes].keys).to eq([:api_key])
  end

  it 'returns an error message if passwords do not match' do
    post '/api/v1/users', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                              "password_confirmation": "assword"
                            }

    expect(response.status).to eq(400)

    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to eq({ message: "passwords do not match" })
  end

  it 'returns an error message if email already taken' do
    post '/api/v1/users', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                              "password_confirmation": "password"
                            }

    expect(response).to be_successful
    expect(response.status).to eq(201)

    post '/api/v1/users', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                              "password_confirmation": "password"
                            }

    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to eq({ message: "email already taken" })
  end

  it 'returns an error message if missing field' do
    post '/api/v1/users', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                              "password_confirmation": ""
                            }

    expect(response.status).to eq(400)
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to eq({ message: "missing field" })
  end
end
