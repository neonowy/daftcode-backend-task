class CartTotalSerializer < ActiveModel::Serializer
  attributes :regular_price

  has_many :sets
  has_many :extras
  has_many :regular_products
end
