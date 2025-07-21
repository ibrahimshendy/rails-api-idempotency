# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from MissingIdempotencyKey, with: :missing_idempotency_key
  end

  private

  def missing_idempotency_key(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    record = exception.respond_to?(:record) ? exception.record : nil

    render json: {
      errors: record.errors.to_hash
    }, status: :unprocessable_entity
  end
end
