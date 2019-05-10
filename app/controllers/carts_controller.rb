class CartsController < ApplicationController
  def show
    render(json: { items: Cart::Item.all, discounts: [] })
  end
end
