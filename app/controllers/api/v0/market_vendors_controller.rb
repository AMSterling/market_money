class Api::V0::MarketVendorsController < ApplicationController
  include Validator
  include ParamHandler
  before_action :set_market, only: %i[index create]
  before_action :param_check, only: %i[create]

  def create
    if mv_finder.exists?
      render json: { data: {}, errors: 'Association already exists' }, status: :unprocessable_entity
    else
      mv = MarketVendor.new(market: set_market, vendor: set_vendor)
      if mv.save
        render json: MarketVendorSerializer.new(mv), status: :created
      else
        render json: { data: {}, errors: 'Parameters Missing or Invalid' }, status: :bad_request
      end
    end
  end

  def destroy
    if mv_finder.exists?
      mv_finder.first.destroy
    else
      render json: { errors: [{ detail: "No MarketVendor with market_id=#{params[:market_vendor][:market_id]} AND vendor_id=#{params[:market_vendor][:vendor_id]} exists" }] }, status: :not_found
    end
  end

  private

  def mv_finder
    MarketVendor.where(
      market_id: params[:market_vendor][:market_id],
      vendor_id: params[:market_vendor][:vendor_id])
  end

  def param_check
    set_market.present? && set_vendor.present?
  end
end
