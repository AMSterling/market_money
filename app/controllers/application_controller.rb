class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(exception)
    render json: { errors: [{ detail: exception.message }] }, status: :not_found
  end
end
