require 'rails_helper'

describe 'Weather API based on JSON 1.0 spec' do
  describe 'It retrieves weather information for a city based on lat and long', :vcr do
    it 'sends a summary of current day weather' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      current_summary = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:current_weather_summary]

      expect(current_summary).to be_a Hash
      expect(current_summary.keys).to eq([:id,
                                          :icon,
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
      expect(current_detailed.keys).to eq([ :id,
                                            :icon,
                                            :description,
                                            :today,
                                            :tonight,
                                            :feels_like,
                                            :humidity,
                                            :visibility,
                                            :uv_index,
                                            :uv_category])
    end

    it 'sends a forecast for the next 8 hours' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      forecast_hourly = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:forecast_hourly]

      expect(forecast_hourly).to be_a Hash
      expect(forecast_hourly.keys).to eq([:hour_1, :hour_2, :hour_3, :hour_4, :hour_5, :hour_6, :hour_7, :hour_8])
      expect(forecast_hourly[:hour_1].keys).to eq([ :id,
                                                  :time_short,
                                                  :icon,
                                                  :temperature])
    end

    it 'sends a forecast for the next 7 days' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      forecast_daily = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:forecast_daily]

      expect(forecast_daily).to be_a Hash
      expect(forecast_daily.keys).to eq([:day_1, :day_2, :day_3, :day_4, :day_5, :day_6, :day_7])
      expect(forecast_daily[:day_1].keys).to eq([ :id,
                                            :icon,
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
