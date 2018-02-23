class Post < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  validates :title, presence: true, length: { in: 6..255}
  validates :description, presence: true, length: { in: 40..1000}
  validates :url, presence: true, length: { maximum: 255 }
  validates :categories, presence: true
  validates :upvotes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :slug, presence: true
  validate :valid_url
  
  default_scope { order("created_at DESC") }

  def valid_url
    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) && !uri.host.nil?
      errors.add(:base, 'Provided URL must be a valid URL')
    end
  rescue URI::InvalidURIError
    errors.add(:base, 'Provided URL must be a valid URL')
  end

  def upvote
    update_column(:upvotes, upvotes + 1)
  end

  def normalize_friendly_id(string)
    super[0..80]
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
