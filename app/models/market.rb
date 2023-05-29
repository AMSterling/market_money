class Market < ApplicationRecord
  extend FilterableModel

  validates :name,
            :street,
            :city,
            :county,
            :state,
            :zip,
            :lat,
            :lon,
            presence: true

  has_many :market_vendors, dependent: :destroy
  has_many :vendors, through: :market_vendors

  class << self
    def filter_proxy = Filters::MarketFilterProxy
  end

  def vendor_count
    vendors.count
  end

  def as_json(options={})
    options[:methods] = [:vendor_count]
    super
  end
end
