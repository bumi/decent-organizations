class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_and_belongs_to_many :posts

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :description, length: { maximum: 1000 }
  validates :slug, presence: true

  def should_generate_new_friendly_id?
    name_changed?
  end
end
