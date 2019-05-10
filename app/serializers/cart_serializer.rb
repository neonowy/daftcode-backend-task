class CartSerializer < ActiveModel::Serializer
  has_many :items
  has_many :discounts
end
