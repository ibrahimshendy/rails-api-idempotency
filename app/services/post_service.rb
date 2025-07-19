# frozen_string_literal: true

class PostService
  def self.create(attributes:)
    post = Post.create! attributes
    post
  end

  def self.update(post:, attributes:)
    post.update! attributes
    post
  end
end
