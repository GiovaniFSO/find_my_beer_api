class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from NoMethodError, with: :no_method_error

  private

  def not_found
    head :not_found
  end

  def record_invalid(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def parameter_missing(exception)
    render json: exception.record.errors, status: :precondition_failed
  end

  def no_method_error(exception)
    render json: exception, status: :precondition_failed
  end
end
