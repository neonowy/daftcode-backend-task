class CartDiscount < ApplicationRecord
  has_and_belongs_to_many :products
  enum kind: [:set, :extra]
end
