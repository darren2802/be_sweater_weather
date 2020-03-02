require 'rails_helper'

describe 'User can register spec' do
  it 'creates a user and returns an API key for a successful registration' do

    post '/api/v1/users', :params => {
                              "email": "whatever@example.com",
                              "password": "password",
                              "password_confirmation": "password"
                            }

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

require "pry"; binding.pry
  end
end
