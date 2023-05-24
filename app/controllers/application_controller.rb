class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def not_found(exception)
    render json: { errors: [{ detail: exception.message }] }, status: :not_found
  end

  # def handle_parameter_missing(exception)
  #   render json: { error: exception.message }, status: :bad_request
  # end
  #
  # def render_unprocessable_entity_response(exception)
  #   render json: exception.record.errors, status: :unprocessable_entity
  # end
end
