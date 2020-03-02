require 'rails_helper'

describe DarkSkyService do
  context 'instance methods' do
    context '#weather_info' do
      it 'returns current and forecast weather info for coordinates' do
        coordinates = {
          lat: 39.7392358,
          lng: -104.990251
        }
        search = subject.weather_info(coordinates)

        expect(search).to be_a Hash
        expect(search.keys).to eq([:latitude, :longitude, :timezone, :currently, :hourly, :daily, :flags, :offset])

        expect(search[:latitude]).to eq(39.7392358)
        expect(search[:longitude]).to eq(-104.990251)

        expect(search[:currently].keys).to eq([:time,
                                   :summary,
                                   :icon,
                                   :nearestStormDistance,
                                   :nearestStormBearing,
                                   :precipIntensity,
                                   :precipProbability,
                                   :temperature,
                                   :apparentTemperature,
                                   :dewPoint,
                                   :humidity,
                                   :pressure,
                                   :windSpeed,
                                   :windGust,
                                   :windBearing,
                                   :cloudCover,
                                   :uvIndex,
                                   :visibility,
                                   :ozone])

        expect(search[:hourly][:data]).to be_an Array
        expect(search[:hourly].keys).to eq([:summary, :icon, :data])

        expect(search[:daily][:data]).to be_an Array
        expect(search[:daily].keys).to eq([:summary, :icon, :data])        
      end
    end
  end
end
