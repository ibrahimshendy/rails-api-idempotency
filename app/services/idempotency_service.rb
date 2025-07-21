# frozen_string_literal: true

class IdempotencyService < BaseService

  # Public: Storing idempotency key for endpoint with it's info
  #
  # attributes - {} hash of key:, resource_type:, resource_id:, status_code:
  # Examples
  #
  #   IdempotencyService.create(
  #     attributes: {
  #         key:, resource_type: resource_id:, status_code:
  #     }
  #   )
  def self.create(attributes:)
    attributes[:endpoint] = self.path
    attributes[:method]   = self.request_method

    IdempotencyKey.create! attributes
  end

  # Retrieve idempotency if exist
  #
  #   IdempotencyService.find_by(key:)
  def self.find_by(key:)
    IdempotencyKey.find_by(key: key, endpoint: self.path, method: self.request_method)
  end

end
