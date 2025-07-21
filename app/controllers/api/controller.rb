# frozen_string_literal: true

class Api::Controller < ActionController::API
  include Tracking
  include Idempotency

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_unprocessable_entity(exception)
    record = exception.respond_to?(:record) ? exception.record : nil

    render json: {
      errors: record.errors.to_hash
    }, status: :unprocessable_entity
  end

end
