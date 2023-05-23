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

  describe 'vendor index and show' do
    it 'fetches all vendors' do

      get '/api/v0/vendors'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      vendors = response_body[:data]

      expect(vendors.count).to eq(6)

      expect(vendors).to be_an Array
      expect(vendors.count).to eq(6)

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
  end
end
