require 'rails_helper'

RSpec.describe TomTomService, :vcr do
  describe 'cash_dispensers' do
    it 'returns nearby atms for coordinates' do
      lat = '33.2896'
      lon = '-87.5251'
      response = TomTomService.cash_dispensers(lat, lon)

      expect(response.keys).to eq([:summary, :results])
      expect(response[:summary]).to have_key(:totalResults)
      expect(response[:summary][:totalResults]).to be_an Integer
      expect(response[:results]).to be_an Array
      response[:results].each do |result|
        expect(result.keys).to include(:dist, :poi, :address, :position)
        expect(result[:dist]).to be_a Float
        expect(result[:poi]).to have_key(:name)
        expect(result[:poi][:name]).to be_a String
        expect(result[:address]).to have_key(:freeformAddress)
        expect(result[:address][:freeformAddress]).to be_a String
        expect(result[:position].keys).to eq([:lat, :lon])
        expect(result[:position][:lat]).to be_a Float
        expect(result[:position][:lon]).to be_a Float
      end
    end
  end
end
