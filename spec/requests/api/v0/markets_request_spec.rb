require 'rails_helper'

RSpec.describe 'Markets API Endpoints', type: :request do
  let!(:markets) { create_list(:market, 4) }
  let!(:m1_vendors) { create_list(:market_vendor, 2, market: markets[0]) }
  let!(:m2_vendors) { create_list(:market_vendor, 1, market: markets[1]) }
  let!(:m3_vendors) { create_list(:market_vendor, 3, market: markets[2]) }
  let!(:vendor1) { m1_vendors[0].vendor }
  let!(:vendor2) { m1_vendors[1].vendor }
  let!(:vendor3) { m2_vendors[0].vendor }
  let!(:vendor4) { m3_vendors[0].vendor }
  let!(:vendor5) { m3_vendors[1].vendor }
  let!(:vendor6) { m3_vendors[2].vendor }
  let!(:vendor7) { create(:vendor) }

  describe 'market CRUD' do
    it 'fetches all markets' do

      get '/api/v0/markets'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      markets = response_body[:data]

      expect(markets.count).to eq(4)

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

    it 'responds with 404 if no vendors accociated with a market' do
      id = markets[3].id

      get "/api/v0/markets/#{id}/vendors"

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:data=>[], :errors=>"No Vendors Associated with Market #{id}"})
    end

    it 'fetches one vendor accociated with a market' do

      get "/api/v0/markets/#{markets[0].id}/vendors/#{vendor1.id}"

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      vendor = response_body[:data]

      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to eq(vendor1.id.to_s)
      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq('vendor')

      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to eq(vendor1.name)
      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to eq(vendor1.description)
      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to eq(vendor1.contact_name)
      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to eq(vendor1.contact_phone)
      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
      expect(vendor[:attributes][:credit_accepted]).to eq(vendor1.credit_accepted)
      expect(vendor[:attributes]).to_not have_key(:created_at)
    end

    it 'responds with 404 if vendor is not associated with market' do

      get "/api/v0/markets/#{markets[0].id}/vendors/#{vendor7.id}"

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Vendor with 'id'=#{vendor7.id} [WHERE \"market_vendors\".\"market_id\" = $1]"}]})
    end
  end

  describe 'market search' do
    let!(:market1) { markets[0] }

    context 'when valid parameters' do
      it 'fetches markets by name' do

        get "/api/v0/markets/search?name=#{market1.name.to(3)}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        markets = response_body[:data]

        markets.each do |market|
          expect(market[:attributes][:name].downcase).to include(market1.name.to(3).downcase)
        end
      end

      it 'fetches markets by state' do

        get "/api/v0/markets/search?state=#{market1.state.to(3)}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        markets = response_body[:data]

        markets.each do |market|
          expect(market[:attributes][:state].downcase).to include(market1.state.to(3).downcase)
        end
      end

      it 'fetches markets by name and state' do

        get "/api/v0/markets/search?name=#{market1.name.to(3)}&state=#{market1.state.to(3)}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        markets = response_body[:data]

        markets.each do |market|
          expect(market[:attributes][:name].downcase).to include(market1.name.to(3).downcase)
          expect(market[:attributes][:state].downcase).to include(market1.state.to(3).downcase)
        end
      end

      it 'fetches markets by city and state' do

        get "/api/v0/markets/search?city=#{market1.city.to(3)}&state=#{market1.state.to(3)}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        markets = response_body[:data]

        markets.each do |market|
          expect(market[:attributes][:city].downcase).to include(market1.city.to(3).downcase)
          expect(market[:attributes][:state].downcase).to include(market1.state.to(3).downcase)
        end
      end

      it 'fetches markets by name, city and state' do

        get "/api/v0/markets/search?name=#{market1.name.to(3)}&city=#{market1.city.to(3)}&state=#{market1.state.to(3)}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        markets = response_body[:data]

        markets.each do |market|
          expect(market[:attributes][:name].downcase).to include(market1.name.to(3).downcase)
          expect(market[:attributes][:city].downcase).to include(market1.city.to(3).downcase)
          expect(market[:attributes][:state].downcase).to include(market1.state.to(3).downcase)
        end
      end

      it 'ignores blank values' do

        get "/api/v0/markets/search?name=&city=#{market1.city.to(3)}&state=#{market1.state.to(3)}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        markets = response_body[:data]

        markets.each do |market|
          expect(market[:attributes][:city].downcase).to include(market1.city.to(3).downcase)
          expect(market[:attributes][:state].downcase).to include(market1.state.to(3).downcase)
        end
      end

      it 'responds with empty data if no markets matching params' do
        name = 123123123123

        get "/api/v0/markets/search?name=#{name}"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to eq({:data=>[]})
      end

    end

    context 'when invalid params' do
      it 'responds with 422 if only city param is passed' do

        get "/api/v0/markets/search?city=#{market1.city.to(3)}"

        expect(response).to_not be_successful
        expect(response).to have_http_status 422
      end

      it 'responds with 422 if name and city' do

        get "/api/v0/markets/search?name=#{market1.name.to(3)}&city=#{market1.city.to(3)}"

        expect(response).to_not be_successful
        expect(response).to have_http_status 422
      end

      it 'responds with 422 if wrong param type passed' do

        get "/api/v0/markets/search?zip=#{market1.zip}"

        expect(response).to_not be_successful
        expect(response).to have_http_status 422
      end

      it 'responds with 422 if param not attribute for market' do

        get "/api/v0/markets/search?description=#{market1.name}"

        expect(response).to_not be_successful
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'nearby cash dispensers' do
    let!(:market) {
      Market.create(
        name: "Uptown Ankeny Farmers Market",
        street: "Corner of SW 3rd & SW Maple Street",
        city: "Ankeny",
        county: "Polk",
        state: "Iowa",
        zip: "50023",
        lat: "41.729882",
        lon: "-93.608108"
      ) }

    context 'valid market ID' do
      it 'fetches nearest atms to a market' do

        get "/api/v0/markets/#{market.id}/nearest_atms"

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)
        atms = response_body[:data]

        expect(atms).to be_an Array
        atms.each do |atm|
          expect(atm).to have_key(:id)
          expect(atm[:id]).to be_nil
          expect(atm).to have_key(:type)
          expect(atm[:type]).to eq('atm')
          expect(atm).to have_key(:attributes)
          expect(atm[:attributes]).to be_a Hash
          expect(atm[:attributes]).to have_key(:name)
          expect(atm[:attributes][:name]).to be_a String
          expect(atm[:attributes]).to have_key(:address)
          expect(atm[:attributes][:address]).to be_a String
          expect(atm[:attributes]).to have_key(:lat)
          expect(atm[:attributes][:lat]).to be_a Float
          expect(atm[:attributes]).to have_key(:lon)
          expect(atm[:attributes][:lon]).to be_a Float
          expect(atm[:attributes]).to have_key(:distance)
          expect(atm[:attributes][:distance]).to be_a Float
          expect(atm).to_not have_key(:created_at)
        end
      end
    end

    context 'invalid market ID' do
      it 'responds with 404 when market cannot be found' do
        id = 123123123123

        get "/api/v0/markets/#{id}/nearest_atms"

        expect(response).to_not be_successful
        expect(response).to have_http_status 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Market with 'id'=123123123123"}]})
      end
    end
  end
end
