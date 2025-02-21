class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validate :url_must_be_valid

  def gist?
    url.match?(/^https:\/\/gist.github.com\//)
  end

  private

  def url_must_be_valid
    uri = URI.parse(url)
    errors.add(:url, 'is not a valid URL') unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    errors.add(:url, 'is not a valid URL')
  end
end
