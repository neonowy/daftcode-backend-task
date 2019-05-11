class Carts::TotalsController < ApplicationController
  def show
    @total = CartTotal.new(CartItem.all)
    render(json: @total)
  end
end
