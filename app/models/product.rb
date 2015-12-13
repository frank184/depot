class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: :title_present?
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jp[e]?g|png)/i,
    message: "Image url must be a URL for a .gif, .jpg, .jpeg or .png"
  }
  validates :title, uniqueness: true
  def title_present?
    title.present?
  end
end
