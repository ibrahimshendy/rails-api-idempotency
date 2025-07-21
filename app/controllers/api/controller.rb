# frozen_string_literal: true

class Api::Controller < ActionController::API
  include Tracking
  include Idempotency
  include ErrorHandler
end
