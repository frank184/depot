require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products, :orders

  test "buying a product" do
    david = orders(:david)
    LineItem.delete_all
    Order.delete_all
    ruby = products(:ruby)

    get "/"
    assert_response :success
    assert_template "index"

    xhr :post, '/line_items', product_id: ruby.id
    assert_response :success

    first_cart_id = session[:cart_id]
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby, cart.line_items.first.product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
    order: {
      name:     david.name,
      address:  david.address,
      email:    david.email,
      pay_type: david.pay_type
    }
    assert_response :success
    assert_template "index"

    second_cart_id = session[:cart_id]
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    assert_not_equal(first_cart_id, second_cart_id)

    assert_equal 1, Order.count
    david = Order.first

    assert_equal "David Thomas", david.name
    assert_equal "123 Fake St.", david.address
    assert_equal "david@example.org", david.email
    assert_equal "Check", david.pay_type

    assert_equal 1, david.line_items.size
    line_item = david.line_items.first
    assert_equal ruby, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["david@example.org"], mail.to
    assert_equal "Sam Ruby <depot@example.com>", mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end

end
