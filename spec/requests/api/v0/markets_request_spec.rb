require 'rails_helper'

RSpec.describe 'Markets API Endpoints' do
  let!(:markets) { create_list(:market, 3) }
  let!(:m1_vendors) { create_list(:market_vendor, 2, market: markets[0]) }
  let!(:m2_vendors) { create_list(:market_vendor, 2, market: markets[1]) }
  let!(:m3_vendors) { create_list(:market_vendor, 3, market: markets[2]) }

  describe 'market index and show' do
    it 'fetches all markets' do

      get '/api/v0/markets'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      markets = response_body[:data]

      expect(markets.count).to eq(3)

      markets.each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_a(String)
        expect(market).to have_key(:type)
        expect(market[:type]).to eq('market')

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
        expect(market[:attributes]).to have_key(:vendor_count)
        expect(market[:attributes][:vendor_count]).to be_an(Integer)
        expect(market[:attributes]).to_not have_key(:created_at)
      end
    end

    it 'fetches one market' do
      id = markets[0].id

      get "/api/v0/markets/#{id}"

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      market = response_body[:data]

      expect(market).to have_key(:id)
      expect(market[:id]).to be_a(String)
      expect(market[:id]).to eq(markets[0].id.to_s)
      expect(market).to have_key(:type)
      expect(market[:type]).to eq('market')

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to eq(markets[0].name)
      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to eq(markets[0].street)
      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to eq(markets[0].city)
      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to eq(markets[0].county)
      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to eq(markets[0].state)
      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to eq(markets[0].zip)
      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to eq(markets[0].lat)
      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to eq(markets[0].lon)
      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_an(Integer)
      expect(market[:attributes]).to_not have_key(:created_at)
    end

    it 'responds with 404 if no market by ID' do
      id = 123123123123

      get "/api/v0/markets/#{id}"

      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Market with 'id'=123123123123"}]})
    end

    describe 'market vendors' do
      it 'fetches vendors associated with a market' do
        id = markets[0].id

        get "/api/v0/markets/#{id}/vendors"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        vendors = response_body[:data]

        expect(vendors).to be_an Array
        expect(vendors.count).to eq(2)

        vendors.each do |vendor|
          expect(vendor).to have_key(:id)
          expect(vendor[:id]).to be_a(String)
          expect(vendor).to have_key(:type)
          expect(vendor[:type]).to eq('vendor')

          expect(vendor).to have_key(:attributes)
          expect(vendor[:attributes]).to have_key(:name)
          expect(vendor[:attributes][:name]).to be_a(String)
          expect(vendor[:attributes]).to have_key(:description)
          expect(vendor[:attributes][:description]).to be_a(String)
          expect(vendor[:attributes]).to have_key(:contact_name)
          expect(vendor[:attributes][:contact_name]).to be_a(String)
          expect(vendor[:attributes]).to have_key(:contact_phone)
          expect(vendor[:attributes][:contact_phone]).to be_a(String)
          expect(vendor[:attributes]).to have_key(:credit_accepted)
          expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
          expect(vendor[:attributes]).to_not have_key(:created_at)
        end
      end
    end
  end
end