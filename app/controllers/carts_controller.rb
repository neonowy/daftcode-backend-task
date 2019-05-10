class CartsController < ApplicationController
  def show
    render(json: Cart.new)
  end
end
