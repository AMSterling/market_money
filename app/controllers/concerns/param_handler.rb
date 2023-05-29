module ParamHandler
  extend ActiveSupport::Concern

  def market_params
    params.require(:market).permit(
      :name,
      :city,
      :state
    )
  end

  def vendor_params
    params.require(:vendor).permit(
      :name,
      :description,
      :contact_name,
      :contact_phone,
      :credit_accepted
    )
  end

  def mv_params
    params.require(:market_vendor)
    .permit(:market_id,
      {
        :vendor => [
          :name,
          :description,
          :contact_name,
          :contact_phone,
          :credit_accepted
        ]
      }
    )
  end
end
