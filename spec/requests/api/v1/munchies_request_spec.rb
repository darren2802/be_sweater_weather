require 'rails_helper'

describe 'Munchies API' do
  it 'can retrieve food and forecast information for a destination city as well
      as travel time to that city' do

    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    expect(response).to be_successful

    munchies = JSON.parse(response.body, symbolize_names: true)

    expect(munchies).to be_a Hash
  end
end
