class Carts::ItemsController < ApplicationController
  def create
    @item = Cart::Item.new(item_params)

    if @item.save
      render_cart
    else
      render(@item.errors, status: :unprocessable_entity)
    end
  end

  def update
    @item = Cart::Item.find(params[:id])

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
    render(json: { items: Cart::Item.all, discounts: [] })
  end

  def item_params
    params.require(:item).permit(:product_id, :quantity)
  end
end
