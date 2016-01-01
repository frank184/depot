class AdminController < ApplicationController
  before_action :set_admin
  def index
    @total_orders = Order.count
  end

  def set_admin
  end
end
