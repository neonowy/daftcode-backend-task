class Carts::ItemsController < ApplicationController
  def create
    @item = CartItem.new(item_params)

    if @item.save
      render_cart
    else
      render(@item.errors, status: :unprocessable_entity)
    end
  end

  def update
    @item = CartItem.find(params[:id])

    if item_params[:quantity].to_i.zero?
      @item.destroy
    else
      @item.update(item_params)
    end

    if @item.valid?
      render_cart
    else
      render(json: @item.errors, status: :unprocessable_entity)
    end
  end

  private
  def render_cart
    render(json: Cart.new)
  end

  def item_params
    params.require(:item).permit(:product_id, :quantity)
  end
end
