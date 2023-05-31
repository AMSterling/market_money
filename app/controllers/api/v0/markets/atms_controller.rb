class Api::V0::Markets::AtmsController < ApplicationController
  include Validator
  before_action :set_market, only: %i[index]

  def index
    atms = CashDispenserFacade.nearby_atms(set_market.lat, set_market.lon)
    render json: AtmSerializer.new(atms)
  end
end
