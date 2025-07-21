# frozen_string_literal: true

class MissingIdempotencyKey < StandardError
  def initialize(message = "You need to sent a Idempotency-Key inside header")
    super
  end
end
