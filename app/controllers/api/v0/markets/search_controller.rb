class Api::V0::Markets::SearchController < ApplicationController
  include FilterableController
  include Validator
  before_action :param_check, only: %i[index]

  def index
    markets = filter(Market.all)
    render json: MarketSerializer.new(markets)
  end

  private

  def param_check
    if (params[:city] && !params[:state]) || filter_params.values.all?(&:nil?)
      render json: { error: 'Invalid Parameters' }, status: :unprocessable_entity
    end
  end

  def filter_params
    {
      name: params["name"],
      city: params["city"],
      state: params["state"]
    }
  end
end
