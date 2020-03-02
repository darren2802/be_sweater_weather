require 'rails_helper'

describe YelpService do
  context 'instance methods' do
    context '#restaurant' do
      it 'returns a restaurant based on location, type, category, and open at time' do
        search = subject.restaurant('pueblo,co', 'food', 'chinese', 1583174868)

        expect(search).to be_a Hash
        expect(search.keys).to eq([:businesses, :total, :region])
        expect(search[:businesses]).to be_an Array
      end
    end
  end
end
