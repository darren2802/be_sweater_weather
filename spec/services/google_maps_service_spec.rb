require 'rails_helper'

describe GoogleMapsService do
  context 'instance methods' do
    context '#coordinates' do
      it 'returns the coordinates for a given city' do
        search = subject.geocode('denver')

        expect(search).to be_an Hash
        expect(search.keys).to eq([:address_components, :formatted_address, :geometry, :place_id, :types])
        expect(search.count).to eq(5)
        expect(search[:address_components]).to be_an Array
        expect(search[:address_components].count).to eq(4)

        expect(search[:geometry][:location]).to eq(
          {:lat=>39.7392358, :lng=>-104.990251}
        )
      end
    end
  end
end
