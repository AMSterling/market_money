class Market < ApplicationRecord
  validates :name,
            :street,
            :city,
            :county,
            :state,
            :zip,
            :lat,
            :lon,
            presence: true

  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  def vendor_count
    vendors.count
  end

  def as_json(options={})
    options[:methods] = [:vendor_count]
    super
  end
end
