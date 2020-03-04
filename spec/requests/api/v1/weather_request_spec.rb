require 'rails_helper'

describe 'Weather API based on JSON 1.0 spec' do
  describe 'It retrieves weather information for a city based on lat and long', :vcr do
    it 'sends a summary of current day weather' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      current_summary = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:current_weather_summary]

      expect(current_summary).to be_a Hash
      expect(current_summary.keys).to eq([:icon,
                                          :description,
                                          :temp_current,
                                          :temp_hi,
                                          :temp_low,
                                          :city,
                                          :state,
                                          :country,
                                          :time,
                                          :date,
                                          :time_short])
    end

    it 'sends details of current day weather' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      current_detailed = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:current_weather_detail]

      expect(current_detailed).to be_a Hash
      expect(current_detailed.keys).to eq([ :icon,
                                            :description,
                                            :today,
                                            :tonight,
                                            :feels_like,
                                            :humidity,
                                            :visibility,
                                            :uv_index,
                                            :uv_category])
    end

    it 'sends a forecast for the next 7 days' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:forecast]

      expect(forecast).to be_a Hash
      expect(forecast.keys).to eq([:day_1, :day_2, :day_3, :day_4, :day_5, :day_6, :day_7])
      expect(forecast[:day_1].keys).to eq([ :icon,
                                            :summary,
                                            :precip_type,
                                            :precip_probability,
                                            :temp_avg,
                                            :temp_low,
                                            :temp_high,
                                            :humidity,
                                            :weekday])
    end
  end
end
