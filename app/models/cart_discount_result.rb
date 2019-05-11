class CartDiscountResult
  include ActiveModel::Serialization
  attr_accessor :discount, :products

  def initialize(discount, products)
    @discount = discount
    @products = products
  end

  def total
    if discount.set?
      return discount.price
    elsif discount.extra?
      return discount.count * products.first.price
    end
  end

  def savings
    full_price - total
  end

  # Including extra products from 'set' discount
  # which were not explicitly ordered
  def products_including_extra
    if discount.set?
      discount.products # return products from discount definition
    else
      products # for 'extra' discount simply return products
    end
  end


  private
  # Price for @products without a discount
  def full_price
    products.sum(&:price)
  end
end
