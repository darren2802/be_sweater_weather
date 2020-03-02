require 'rails_helper'

describe 'Background request spec' do
  it 'returns the url of the requested location' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    
  end
end
