require 'rails_helper'

RSpec.describe 'Vendor API endpoints' do
  let!(:markets) { create_list(:market, 3) }
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

  describe 'vendor CRUD' do
    it 'fetches all vendors' do

      get '/api/v0/vendors'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      vendors = response_body[:data]

      expect(vendors.count).to eq(7)

      expect(vendors).to be_an Array
      expect(vendors.count).to eq(7)

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

    it 'fetches one vendor' do
      id = vendor1.id

      get "/api/v0/vendors/#{id}"

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

    it 'responds with 404 if no vendor by ID' do
      id = 123123123123

      get "/api/v0/vendors/#{id}"

      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Vendor with 'id'=123123123123"}]})
    end

    it 'fetches markets accociated with a vendor' do

      get "/api/v0/vendors/#{vendor1.id}/markets"

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      markets = response_body[:data]

      expect(markets).to be_an Array
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

    it 'responds with 404 if no markets accociated with a vendor' do

      get "/api/v0/vendors/#{vendor7.id}/markets"

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:data=>[], :errors=>"No Markets Associated with Vendor #{vendor7.id}"})
    end

    it 'fetches one market accociated with a vendor' do

      get "/api/v0/vendors/#{vendor1.id}/markets/#{markets[0].id}"

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

    it 'responds with 404 if market is not associated with vendor' do

      get "/api/v0/vendors/#{vendor7.id}/markets/#{markets[0].id}"

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:errors=>[{:detail=>"Couldn't find Market with 'id'=#{markets[0].id} [WHERE \"market_vendors\".\"vendor_id\" = $1]"}]})
    end

    it 'creates and then deletes a vendor' do
      vendor_params = {
        name: Faker::Company.name,
        description: Faker::Lorem.paragraph,
        contact_name: Faker::Name.name,
        contact_phone: Faker::PhoneNumber.phone_number,
        credit_accepted: [true, false].sample
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)
      created_vendor = Vendor.last

      expect(response).to have_http_status(201)
      expect(Vendor.count).to eq(8)
      expect(created_vendor.name).to eq(vendor_params[:name])
      expect(created_vendor.description).to eq(vendor_params[:description])
      expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
      expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
      expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])

      delete "/api/v0/vendors/#{created_vendor.id}"

      expect(response).to have_http_status(204)
      expect(Vendor.count).to eq(7)
      expect { Vendor.find(created_vendor.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'responds with 400 if vendor cannot be created' do
      vendor_params = {
        name: Faker::Company.name,
        description: Faker::Lorem.paragraph,
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)

      expect(response).to have_http_status(400)
      expect(response.message).to eq('Bad Request')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:data=>{}, :errors=>"Parameters Missing or Invalid"})
    end

    it 'updates an existing vendor' do
      id = create(:vendor).id
      previous_name = Vendor.last.name
      vendor_params = { name: Faker::Commerce.product_name }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate(vendor: vendor_params)
      vendor = Vendor.find_by(id: id)

      expect(response).to be_successful
      expect(vendor.name).to_not eq(previous_name)
      expect(vendor_params[:name]).to eq(vendor.name)
    end

    it 'responds with 400 if vendor cannot be updated' do
      id = create(:vendor).id
      Vendor.last.name

      vendor_params = { name: '' }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate(vendor: vendor_params)
      Vendor.find_by(id: id)

      expect(response).to have_http_status(400)
      expect(response.message).to eq('Bad Request')

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({:data=>{}, :errors=>"Parameters Missing or Invalid"})
    end
  end
end
