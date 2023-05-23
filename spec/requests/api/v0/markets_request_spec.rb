require 'rails_helper'

RSpec.describe 'Markets API Endpoints' do
  let!(:markets) { create_list(:market, 5) }
  let!(:vendors) { create_list(:vendor, 5) }

  describe 'market index and show' do
    it 'fetches all markets' do
      get '/api/v0/markets'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      markets = response_body[:data]

      expect(markets.count).to eq(5)

      markets.each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_a(String)

        expect(market).to have_key(:attributes)
        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes][:name]).to be_a(String)
        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_a(String)
        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_a(String)
        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_a(String)
        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_a(String)
        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_a(String)
        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_a(String)
        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_a(String)
        expect(market[:attributes]).to_not have_key(:created_at)
      end
    end
  end
end
