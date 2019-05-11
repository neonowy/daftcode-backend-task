class CartDiscount < ApplicationRecord
  has_and_belongs_to_many :products
  enum kind: [:set, :extra]

  def get_possible_results_for(items)
    if set?
      eligible_products = get_eligible_items_for_set(items)
      return eligible_products.empty? ? [] : [CartDiscountResult.new(self, eligible_products)]
    elsif extra?
      return get_eligible_items_for_extra(items).map { |product| CartDiscountResult.new(self, [product] * (count + 1)) }
    end
  end

  private
  def get_eligible_items_for_set(items)
    products_ids_of_items = items.flat_map { |item| [item.product_id] * item.quantity }
    intersection_with_duplicates_of(product_ids, products_ids_of_items).map { |id| Product.find(id) }
  end

  def get_eligible_items_for_extra(items)
    products_ids_of_items = items.flat_map { |item| [item.product_id] * item.quantity }

    (product_ids & products_ids_of_items).map { |id|
      if products_ids_of_items.count(id) > count
        Product.find(id)
      else
        nil
      end
    }.compact
  end

  def intersection_with_duplicates_of(array_a, array_b)
    counts_a = array_a.each_with_object(Hash.new(0)) { |item, hash| hash[item] += 1 }
    counts_b = array_b.each_with_object(Hash.new(0)) { |item, hash| hash[item] += 1 }

    (array_a & array_b).flat_map { |item| [item] * [counts_a[item], counts_b[item]].min }
  end
end
