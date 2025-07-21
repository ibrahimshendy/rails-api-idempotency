# frozen_string_literal: true

module Tracking
  extend ActiveSupport::Concern

  included do
    before_action :start_tracking
  end

  private

  def start_tracking
    BaseService.setup(
      **{
        path: request.path,
        request_method: request.method,
        ip_address: request.remote_ip,
        idempotency_key: request.headers["Idempotency-Key"]
      }
    )
  end
end
