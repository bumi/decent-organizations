class Post < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { in: 6..255}
  validates :description, presence: true, length: { in: 40..1000}
  validates :url, presence: true, length: { maximum: 255 }
  validates :categories, presence: true
  validate :valid_url

  def valid_url
    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) && !uri.host.nil?
      errors.add(:base, 'Provided URL must be a valid URL')
    end
  rescue URI::InvalidURIError
    errors.add(:base, 'Provided URL must be a valid URL')
  end
end
