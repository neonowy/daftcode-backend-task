class CartDiscountSerializer < ActiveModel::Serializer
  attributes :id, :kind, :name, :product_ids
  attribute :price, if: -> { object.set? }
  attribute :count, if: -> { object.extra? }
end
