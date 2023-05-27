class Api::V0::Markets::VendorsController < ApplicationController
  include Validator
  include ParamHandler
  before_action :set_market, only: %i[index]

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
end
