class Api::V0::VendorMarketsController < ApplicationController
  include Validator
  before_action :set_vendor, only: %i[index show]

  def index
    markets = set_vendor.markets
    if !markets.empty?
      render json: MarketSerializer.new(markets)
    else
      render json: { data: [], errors: "No Markets Associated with Vendor #{set_vendor.id}" }, status: :not_found
    end
  end

  def show
    market = set_vendor.markets.find(params[:market_id])
    render json: MarketSerializer.new(market)
  end
end
