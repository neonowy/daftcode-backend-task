class Carts::DiscountsController < ApplicationController
  def create
    @discount = CartDiscount.new(discount_params)

    if @discount.save
      render_cart
    else
      render(@discount.errors, status: :unprocessable_entity)
    end
  end

  def update
    @discount = CartDiscount.find(params[:id])

    if @discount.update(discount_params)
      render_cart
    else
      render(json: @discount.errors, status: :unprocessable_entity)
    end
  end

  private
  def render_cart
    render(json: Cart.new)
  end

  def discount_params
    params.require(:discount).permit(:kind, :name, :price, :count, :product_ids => [])
  end
end
