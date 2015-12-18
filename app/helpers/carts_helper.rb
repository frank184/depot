module CartsHelper

  def has_cart?
    @cart.nil?
  end

  def cart_empty?
    @cart.empty?
  end

end
