# frozen_string_literal: true

class BaseService
  cattr_accessor :path, :request_method, :ip_address, :idempotency_key

  def self.setup(path:, request_method:, ip_address:, idempotency_key:)
    self.path             = path
    self.request_method   = request_method.to_s.upcase
    self.ip_address       = ip_address
    self.idempotency_key  = idempotency_key
  end
end
