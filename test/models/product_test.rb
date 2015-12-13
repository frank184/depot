require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attribute must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product title must be unique" do
    product = new_product
    product.title = products(:ruby).title
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test "product price must be positive" do
    product = new_product
    product.price = -1
    assert product.invalid?
    count = 0.01

    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    product.price = 1
    assert product.valid?
  end

  test "product image_url must be of certain types" do
    ok =  %w{ fred.gif fred.jpg fred.jpeg fred.png
          FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |url|
      product = new_product
      product.image_url = url
      assert product.valid?, "#{url} should be valid"
    end

    bad.each do |url|
      product = new_product
      product.image_url = url
      assert product.invalid?, "#{url} should be invalid"
    end
  end

  def new_product
    Product.new(title:"xyz", description:"xyz", price:1, image_url:"xyz.jpg")
  end

end
