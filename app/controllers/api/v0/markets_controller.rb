class Api::V0::MarketsController < ApplicationController
  include Validator
  before_action :set_market, only: %i[show]

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(Market.find(params[:id]))
  end
end
