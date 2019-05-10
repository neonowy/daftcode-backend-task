class Cart::Item < ApplicationRecord
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :product_id, uniqueness: true
  belongs_to :product
end
