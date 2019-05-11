class CartDiscountResultSerializer < ActiveModel::Serializer
  attributes :name, :total
  has_many :products

  def name
    object.discount.name
  end

  def products
    object.products_including_extra
  end

  def total
    object.total
  end
end
