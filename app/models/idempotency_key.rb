class IdempotencyKey < ApplicationRecord
  belongs_to :resource, polymorphic: true

  # validates attributes
  validates :key, presence: true, uniqueness: { scope: [:endpoint, :method] }
  validates :endpoint, presence: true
  validates :method, presence: true
  validates :status_code, presence: true

end
