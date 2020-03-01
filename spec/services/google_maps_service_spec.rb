require 'rails_helper'

describe GoogleMapsService do
  context 'instance methods' do
    context '#coordinates' do
      it 'returns the coordinates for a given city' do
        search = subject.coordinates('denver')

        expect(search).to be_an Array
        expect(search.count).to eq(1)
        expect(search[0]).to be_a Hash
        expect(search[0].keys).to eq([:address_components, :formatted_address, :geometry, :place_id, :types])

        expect(search[0][:geometry][:location]).to eq(
          {:lat=>39.7392358, :lng=>-104.990251}
        )
      end
    end
  end
end
