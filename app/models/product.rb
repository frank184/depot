class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

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

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        true
      else
        errors.add(:base, "Line Item present")
      end
    end

end
