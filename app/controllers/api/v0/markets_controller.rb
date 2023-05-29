class Api::V0::MarketsController < ApplicationController
  include Filterable
  include Validator
  before_action :set_market, only: %i[show]
  before_action :param_check, only: %i[index]

  def index
    render json: MarketSerializer.new(filter(Market.all))
  end

  def show
    render json: MarketSerializer.new(set_market)
  end

  private

  def param_check
    render status: :unprocessable_entity if params[:city] && !params[:state]
  end

  def filter_params
    {
      name: params[:name],
      city: params[:city],
      state: params[:state]
    }
  end
end
