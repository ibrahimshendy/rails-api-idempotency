# frozen_string_literal: true

module Idempotency
  extend ActiveSupport::Concern

  included do
    before_action :validate_idempotency_key, only: :create
  end

  private

  def validate_idempotency_key
    key = request.headers["Idempotency-Key"]

    raise MissingIdempotencyKey if key.blank?

    idempotency = IdempotencyService.find_by(key: key)
    render json: idempotency.resource, status: idempotency.status_code if idempotency.present?
  end

end
