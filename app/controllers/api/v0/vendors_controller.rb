class Api::V0::VendorsController < ApplicationController
  include Validator
  before_action :set_vendor, only: %i[show]
  def index
    vendors = Vendor.all
    render json: VendorSerializer.new(vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end
end
