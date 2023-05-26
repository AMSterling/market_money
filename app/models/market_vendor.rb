class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor, inverse_of: :market_vendors

  accepts_nested_attributes_for :market, :vendor, reject_if: :all_blank, allow_destroy: true
end
