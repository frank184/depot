class CombineItmesInCart < ActiveRecord::Migration
  def change
    Cart.all.each do |cart|
      # count the number of each product in the Cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(product_id: product_id).delete_all
          # replace with a single items
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end
end
