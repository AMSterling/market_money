module Validator
  extend ActiveSupport::Concern

  def set_market
    Market.find(params[:id])
  end

  def set_vendor
    Vendor.find(params[:id])
  end
end
