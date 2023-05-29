require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :county }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lon }
  end

  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'model methods' do
    let!(:markets) { create_list(:market, 3) }
    let!(:m1_vendors) { create_list(:market_vendor, 2, market: markets[0]) }
    let!(:m2_vendors) { create_list(:market_vendor, 2, market: markets[1]) }
    let!(:m3_vendors) { create_list(:market_vendor, 3, market: markets[2]) }
    let!(:vendor1) { m1_vendors[0].vendor }

    describe '.vendor_count' do
      it 'returns number of vendors accociated with a market' do

        expect(markets[0].vendor_count).to eq(2)
      end
    end

    describe '#as_json' do
      it 'assigns instance methods as attributes' do

        expect(markets[0].to_json).to include('vendor_count')
      end
    end

    describe '::filter_by' do
      context '#name' do
        it 'scopes markets by name' do
          name_search = markets[0].name.to(4)

          Market.filter_by(name: name_search).each do |market|
            expect(market.name.downcase).to include(markets[0].name.to(4).downcase)
          end
        end
      end

      context '#city' do
        it 'scopes markets by city' do
          city_search = markets[0].city.to(3)

          Market.filter_by(city: city_search).each do |market|
            expect(market.city.downcase).to include(markets[0].city.to(3).downcase)
          end
        end
      end

      context '#state' do
        it 'scopes markets by state' do
          state_search = markets[0].state.to(3)

          Market.filter_by(state: state_search).each do |market|
            expect(market.state.downcase).to include(markets[0].state.to(3).downcase)
          end
        end
      end

      context '#name_state' do
        it 'scopes markets by name and state' do
          name_search = markets[0].name.to(3)
          state_search = markets[0].state.to(3)

          Market.filter_by(name: name_search, state: state_search).each do |market|

            expect(market.name.downcase).to include(markets[0].name.to(3).downcase)
            expect(market.state.downcase).to include(markets[0].state.to(3).downcase)
          end
        end
      end

      context '#name_city_state' do
        it 'scopes markets by name, city and state' do
          name_search = markets[0].name.to(3)
          city_search = markets[0].city.to(3)
          state_search = markets[0].state.to(3)


          Market.filter_by(
            name: name_search,
            city: city_search,
            state: state_search).each do |market|

            expect(market.name.downcase).to include(markets[0].name.to(3).downcase)
            expect(market.city.downcase).to include(markets[0].city.to(3).downcase)
            expect(market.state.downcase).to include(markets[0].state.to(3).downcase)
          end
        end
      end
    end
  end
end
