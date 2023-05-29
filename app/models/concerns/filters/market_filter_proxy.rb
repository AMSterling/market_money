module Filters
  module MarketFilterScopes
    extend FilterScopeable

    # We define scopes with out new method
    filter_scope :name, ->(name) { where("name ILIKE ?", "%#{name}%") }
    filter_scope :city, ->(city) { where('city ILIKE ?', "%#{city}%") }
    filter_scope :state, ->(state) { where('state ILIKE ?', "%#{state}%") }
  end

  class MarketFilterProxy < FilterProxy
    def self.query_scope = Market
    def self.filter_scopes_module = Filters::MarketFilterScopes
  end
end
