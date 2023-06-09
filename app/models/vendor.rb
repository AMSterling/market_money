class Vendor < ApplicationRecord
  validates :name, :description, :contact_name, :contact_phone, presence: true
  validates :credit_accepted, inclusion: [true, false]

  has_many :market_vendors, dependent: :destroy
  has_many :markets, through: :market_vendors
end
