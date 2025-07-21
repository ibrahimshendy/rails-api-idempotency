# frozen_string_literal: true

class PostService < BaseService

  def self.create(attributes:)
    ActiveRecord::Base.transaction do
      post = Post.create! attributes

      # storing idempotency key
      IdempotencyService.create attributes: {
        key: self.idempotency_key, resource_type: Post.name, resource_id: post.id, status_code: 201
      }

      post
    end
  end

  def self.update(post:, attributes:)
    post.update! attributes
    post
  end
end
