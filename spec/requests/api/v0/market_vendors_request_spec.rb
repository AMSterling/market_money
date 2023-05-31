require 'rails_helper'

RSpec.describe 'MarketVendors API endpoints', type: :request do
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

  describe 'market vendor CRUD' do
    it 'creates and deletes a market vendor' do
      mv_params = {
        market_id: markets[0].id,
        vendor: {
          name: Faker::Company.name,
          description: Faker::Lorem.paragraph,
          contact_name: Faker::Name.name,
          contact_phone: Faker::PhoneNumber.phone_number,
          credit_accepted: [true, false].sample
        }
      }

      expect(Vendor.count).to eq(7)
      expect(MarketVendor.count).to eq(6)

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)
      created_mv = MarketVendor.last
      created_vendor = Vendor.last

      expect(response).to have_http_status(201)
      expect(Vendor.count).to eq(8)
      expect(MarketVendor.count).to eq(7)
      expect(markets[0].vendors.count).to eq(3)
      expect(created_mv.market).to eq(markets[0])
      expect(created_mv.vendor).to eq(created_vendor)

      response_body = JSON.parse(response.body, symbolize_names: true)
      json = response_body[:data]

      expect(json).to have_key(:id)
      expect(json[:id]).to eq(created_mv.id.to_s)
      expect(json).to have_key(:type)
      expect(json[:type]).to eq('market_vendor')
      expect(json).to have_key(:attributes)
      expect(json[:attributes].keys).to eq([:market_id, :vendor_id])
      expect(json[:attributes][:market_id]).to eq(created_mv.market_id)
      expect(json[:attributes][:vendor_id]).to eq(created_mv.vendor_id)

      params_for_removal = {
        market_id: markets[0].id,
        vendor_id: created_vendor.id
      }

      delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: params_for_removal)

      expect(response).to have_http_status(204)
      require "pry"; binding.pry
      expect(markets[0].vendors.count).to eq(2)
      expect { MarketVendor.find(created_mv.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'New MarketVendor' do
    it 'creates a new association' do
      mv_params = {
        market_id: markets[3].id,
        vendor_id: vendor7.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)
      created_mv = MarketVendor.last

      expect(response).to have_http_status(201)
      expect(markets[3].vendors.count).to eq(1)
      expect(created_mv.market).to eq(markets[3])
      expect(created_mv.vendor).to eq(vendor7)

      response_body = JSON.parse(response.body, symbolize_names: true)
      json = response_body[:data]

      expect(json).to have_key(:id)
      expect(json[:id]).to eq(created_mv.id.to_s)
      expect(json).to have_key(:type)
      expect(json[:type]).to eq('market_vendor')
      expect(json).to have_key(:attributes)
      expect(json[:attributes].keys).to eq([:market_id, :vendor_id])
      expect(json[:attributes][:market_id]).to eq(created_mv.market_id)
      expect(json[:attributes][:market_id]).to eq(markets[3].id)
      expect(json[:attributes][:vendor_id]).to eq(created_mv.vendor_id)
      expect(json[:attributes][:vendor_id]).to eq(vendor7.id)
    end

    it 'creates a new vendor for a market' do
      mv_params = {
        market_id: markets[0].id,
        vendor: {
          name: Faker::Company.name,
          description: Faker::Lorem.paragraph,
          contact_name: Faker::Name.name,
          contact_phone: Faker::PhoneNumber.phone_number,
          credit_accepted: [true, false].sample
        }
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)
      created_mv = MarketVendor.last
      created_vendor = Vendor.last

      expect(response).to have_http_status(201)

      response_body = JSON.parse(response.body, symbolize_names: true)
      json = response_body[:data]

      expect(json).to have_key(:id)
      expect(json[:id]).to eq(created_mv.id.to_s)
      expect(json).to have_key(:type)
      expect(json[:type]).to eq('market_vendor')
      expect(json).to have_key(:attributes)
      expect(json[:attributes].keys).to eq([:market_id, :vendor_id])
      expect(json[:attributes][:market_id]).to eq(created_mv.market_id)
      expect(json[:attributes][:vendor_id]).to eq(created_mv.vendor_id)
    end

    it 'responds with 422 if association already exists' do
      mv_params = {
        market_id: markets[0].id,
        vendor_id: vendor1.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to have_http_status(422)
      expect(response.message).to eq('Unprocessable Entity')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:data=>{}, :errors=>"Association already exists"})
    end

    it 'responds with 400 if MarketVendor cannot be created' do
      mv_params = {
        market_id: markets[0].id,
        vendor: {
          name: '',
          description: Faker::Lorem.paragraph,
          contact_name: Faker::Name.name,
          contact_phone: Faker::PhoneNumber.phone_number,
          credit_accepted: [true, false].sample
        }
      }

      expect(Vendor.count).to eq(7)
      expect(MarketVendor.count).to eq(6)

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to have_http_status(400)
      expect(response.message).to eq('Bad Request')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:data=>{}, :errors=>"Parameters Missing or Invalid"})
    end

    it 'responds with 404 if vendor does not exist' do
      mv_params = {
        market_id: markets[0].id,
        vendor_id: 123123123123123123123
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to have_http_status(404)
      expect(response.message).to eq('Not Found')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Vendor with 'id'=123123123123123123123"}]})
    end

    it 'responds with 404 if market does not exist' do
      mv_params = {
        market_id: 123123123123123123123,
        vendor_id: vendor7.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to have_http_status(404)
      expect(response.message).to eq('Not Found')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Market with 'id'=123123123123123123123"}]})
    end
  end

  describe 'Destroy MarketVendor' do
    it 'deletes an association' do
      params_for_removal = {
        market_id: markets[0].id,
        vendor_id: vendor1.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: params_for_removal)

      expect(response).to have_http_status(204)
      expect(markets[0].vendors.count).to eq(1)
      expect { MarketVendor.find(m1_vendors[0].id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'responds with 404 if MarketVendor does not exist' do
      mv_params = {
        market_id: markets[0].id,
        vendor_id: 123123123123123123123
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to have_http_status(404)
      expect(response.message).to eq('Not Found')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"No MarketVendor with market_id=#{markets[0].id} AND vendor_id=123123123123123123123 exists"}]})
    end

    it 'responds with 404 if market does not exist' do
      mv_params = {
        market_id: 123123123123123123123,
        vendor_id: vendor7.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: mv_params)

      expect(response).to have_http_status(404)
      expect(response.message).to eq('Not Found')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"No MarketVendor with market_id=123123123123123123123 AND vendor_id=#{vendor7.id} exists"}]})
    end
  end
end
