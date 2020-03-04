require 'rails_helper'

describe GoogleMapsService do
  context 'instance methods' do
    context '#coordinates' do
      it 'returns the coordinates for a given city' do
        search = subject.geocode('denver')

        expect(search).to be_an Hash
        expect(search.keys).to eq([:address_components, :formatted_address, :geometry, :place_id, :types])
        expect(search[:address_components]).to be_an Array
        expect(search[:geometry]).to be_an Hash
        expect(search[:geometry].keys).to eq([:bounds, :location, :location_type, :viewport])
      end
    end
  end
end
