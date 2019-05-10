class CartSerializer < ActiveModel::Serializer
  attributes :discounts
  has_many :items
end
