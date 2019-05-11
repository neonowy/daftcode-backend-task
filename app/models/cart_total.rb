class CartTotal
  include ActiveModel::Serialization
  attr_accessor :items, :discount_results

  def initialize(items)
    @items = items
    @discount_results = best_discounts_for(items)
  end

  def sets
    @discount_results.filter { |result| result.discount.set? }
  end

  def extras
    @discount_results.filter { |result| result.discount.extra? }
  end

  def regular_products
    discounted_products_count = discounted_products.each_with_object(Hash.new(0)) do |p, hash|
      hash[p] += 1
    end

    cart_products.reject { |p| discounted_products_count[p] > 0 && discounted_products_count[p] -= 1 }
  end

  def regular_price
    items.sum { |item| item.quantity * item.product.price }
  end

  private
  def best_discounts_for(items, used_discounts = [])
    if items.empty?
      return 0
    else
      discount_results = CartDiscount
        .all
        .flat_map { |discount| discount.get_possible_results_for(items) }
        .filter { |result| result.savings > 0 }

      if discount_results.empty?
        return used_discounts
      else
        return discount_results.map { |result|
          items_left = items.map { |i| i.dup }
          result.products.each { |product|
            item_index = items_left.find_index { |item| item.product_id == product.id }

            items_left[item_index].quantity -= 1
            if items_left[item_index].quantity.zero?
              items_left.delete_at(item_index)
            end
          }

          [result] + best_discounts_for(items_left)
        }.max { |results| results.sum(&:savings) }
      end
    end
  end

  def cart_products
    items.flat_map { |item| [item.product] * item.quantity }
  end

  def discounted_products
    discount_results.flat_map(&:products)
  end
end
