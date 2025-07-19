class Post < ApplicationRecord

  enum :status, %i(draft published trashed), validate: true

  # validation
  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 5 }

end
