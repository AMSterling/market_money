class Api::V0::VendorsController < ApplicationController
  include Validator
  before_action :set_vendor, only: %i[show]

  def index
    vendors = Vendor.all
    render json: VendorSerializer.new(vendors)
  end

  def show
    render json: VendorSerializer.new(set_vendor)
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: { data: {}, errors: 'Parameters Missing or Invalid' }, status: :bad_request
    end
  end

  def update
    if set_vendor.update(vendor_params)
      render json: VendorSerializer.new(set_vendor)
    else
      render json: { data: {}, errors: 'Parameters Missing or Invalid' }, status: :bad_request
    end
  end

  def destroy
    set_vendor.destroy
  end

  private

  def vendor_params
    params.require(:vendor).permit(
      :name,
      :description,
      :contact_name,
      :contact_phone,
      :credit_accepted
    )
  end
end
