require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:david))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["david@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Thank you for your recent order from the Pragmatic Store./, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:david))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["david@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /This is just to let you know that we've shipped your recent order:/, mail.body.encoded
  end

end
