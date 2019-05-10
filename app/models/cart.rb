class Cart
  include ActiveModel::Serialization
  attr_accessor :items, :discounts

  def initialize(items = CartItem.all, discounts = CartDiscount.all)
    @items = items
    @discounts = discounts
  end
end
