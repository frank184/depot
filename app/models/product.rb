class Product < ActiveRecord::Base
  validates :title, :description, :price, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: 'price.present?'
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jp[e]?g|png)\z/i,
    message: "Image url must be a URL for a .gif, .jpg, .jpeg or .png"
  }
  validates :title, uniqueness: true

  def self.latest
    Product.order(:updated_at).last
  end

end
