class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def not_found
    head :not_found
  end

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end
end
