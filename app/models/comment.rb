class Comment < ApplicationRecord
  belongs_to :post

  validates :text, presence: true, length: { in: 5..1000 }
  validates :post, presence: true

  default_scope { order("created_at DESC") }
end
