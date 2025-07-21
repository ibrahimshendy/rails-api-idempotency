# frozen_string_literal: true

class Api::Controller < ActionController::API
  before_action :path_request_info
  before_action :validate_idempotency_key, only: :create

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_unprocessable_entity(exception)
    record = exception.respond_to?(:record) ? exception.record : nil

    render json: {
      errors: record.errors.to_hash
    }, status: :unprocessable_entity
  end

  def path_request_info
    BaseService.setup(
      **{
        path: request.path,
        request_method: request.method,
        ip_address: request.remote_ip,
        idempotency_key: request.headers["Idempotency-Key"]
      }
    )
  end

  def validate_idempotency_key
    key = request.headers["Idempotency-Key"]

    # TODO : split into a single custom error class.
    return render json: { error: "Missing idempotency key" }, status: :not_found if key.blank?

    idempotency = IdempotencyService.find_by(key: key)

    render json: idempotency.resource, status: idempotency.status_code if idempotency.present?
  end

end
