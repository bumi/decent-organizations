class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  has_and_belongs_to_many :posts

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :description, length: { maximum: 1000 }
end
