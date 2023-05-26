class Api::V0::MarketVendorsController < ApplicationController
  include Validator
  include ParamHandler
  before_action :set_market, only: %i[index create]
  before_action :param_check, only: %i[create]

  def index
    vendors = set_market.vendors
    if !vendors.empty?
      render json: VendorSerializer.new(vendors)
    else
      render json: { data: [], errors: "No Vendors Associated with Market #{set_market.id}" }, status: :not_found
    end
  end

  def show
    vendor = set_market.vendors.find(params[:vendor_id])
    render json: VendorSerializer.new(vendor)
  end

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
    unless set_market.present? && set_vendor.present?
      render json: { data: {}, errors: 'Parameters Missing or Invalid' }, status: :bad_request
    end
  end

  # def set_market
  #   if params[:market_id].present?
  #     @market = Market.find(params[:market_id])
  #   elsif params[:market_vendor][:market_id].present?
  #     @market = Market.find(mv_params[:market_id])
  #   end
  # end
  #
  # def set_vendor
  #   if params[:market_vendor][:vendor_id].present?
  #     @vendor = Vendor.find(params[:market_vendor][:vendor_id])
  #   elsif params[:market_vendor][:vendor].present?
  #     @vendor = Vendor.new(mv_params[:vendor])
  #   end
  # end

end
