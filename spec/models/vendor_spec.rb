require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_phone }
    # it { should validate_inclusion_of(:credit_accepted).in_array([true, false]) }
  end

  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end

  describe "#credit_accepted" do
    let!(:vendor1) { create(:vendor, credit_accepted: false) }
    let!(:vendor2) { create(:vendor, credit_accepted: true) }

    it "only allows true or false" do
      vendor3 = Vendor.new(
        name: Faker::Company.name,
        description: Faker::Lorem.paragraph,
        contact_name: Faker::Name.name,
        contact_phone: Faker::PhoneNumber.phone_number,
        credit_accepted: nil
      )
      expect(vendor1).to be_valid
      expect(vendor2).to be_valid
      expect(vendor3).to be_invalid
    end
  end
end
