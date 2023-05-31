require 'rails_helper'

RSpec.describe Atm, :vcr do
  it 'exists with attributes' do
    lat = '33.2896'
    lon = '-87.5251'
    atm = Atm.new(TomTomService.cash_dispensers(lat,lon)[:results].first)

    expect(atm.id). to eq(nil)
    expect(atm.name).to eq('Bank of Tuscaloosa')
    expect(atm.address).to eq('4901 Rice Mine Road Northeast, Tuscaloosa, AL 35406')
    expect(atm.lat).to eq(33.26297)
    expect(atm.lon).to eq(-87.515297)
    expect(atm.distance).to eq(3098.151712)
  end
end
