module Validator
  extend ActiveSupport::Concern

  def set_market
    if params[:id]
      Market.find(params[:id])
    elsif params[:market_id].present?
      Market.find(params[:market_id])
    elsif params[:market_vendor][:market_id].present?
      Market.find(mv_params[:market_id])
    end
  end

  def set_vendor
    if params[:id]
      Vendor.find(params[:id])
    elsif params[:vendor_id]
      Vendor.find(params[:vendor_id])
    elsif params[:market_vendor][:vendor_id].present?
      Vendor.find(params[:market_vendor][:vendor_id])
    elsif params[:market_vendor][:vendor].present?
      Vendor.new(mv_params[:vendor])
    end
  end
end
