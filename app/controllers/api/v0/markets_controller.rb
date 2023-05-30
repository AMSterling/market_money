class Api::V0::MarketsController < ApplicationController
  include FilterableController
  include Validator
  before_action :set_market, only: %i[show]
  before_action :param_check, only: %i[search]

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    render json: MarketSerializer.new(set_market)
  end

  def search
    markets = filter(Market.all)
    render json: MarketSerializer.new(markets)
  end

  private

  def param_check
    render status: :unprocessable_entity if (params[:city] && !params[:state]) ||
    filter_params.all? { |k, v| v.nil? }
  end

  def filter_params
    {
      name: params["name"],
      city: params["city"],
      state: params["state"]
    }
  end
end
