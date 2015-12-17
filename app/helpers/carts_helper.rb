module CartsHelper
  def cart_has_any_line_items?
    @cart.line_items.any?
  end
end
