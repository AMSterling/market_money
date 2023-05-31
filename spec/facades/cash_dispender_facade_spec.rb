require 'rails_helper'

RSpec.describe CashDispenserFacade, :vcr do
  describe 'atms' do
    it 'returns number of jewelry retail stores for coordinates' do
      lat = '33.2896'
      lon = '-87.5251'
      atms = CashDispenserFacade.nearby_atms(lat, lon)

      expect(atms).to be_an Array
      atms.each do |atm|
        expect(atm.id).to be_nil
        expect(atm.name).to be_a String
        expect(atm.address).to be_a String
        expect(atm.lat).to be_a Float
        expect(atm.lon).to be_a Float
        expect(atm.distance).to be_a Float
      end
    end
  end
end
