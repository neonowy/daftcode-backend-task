require 'rails_helper'

RSpec.describe Carts::ItemsController, type: :controller do
  describe 'POST #create' do
    context 'with product_id and quantity' do
      let (:params) { { item: { product_id: 5, quantity: 5 } } }

      it 'creates new item' do
        post(:create, params: params)

        expect(Cart::Item.first.product_id).to eq(5)
        expect(Cart::Item.first.quantity).to eq(5)
      end

      it 'renders cart with items and discounts' do
        post(:create, params: params)

        cart = JSON.parse(response.body)
        expect(cart['items'].size).to eq(1)
        expect(cart['discounts'].size).to eq(0)
      end
    end

    context 'with product_id only' do
      let (:params) { { item: { product_id: 8 } } }

      it 'creates new item with default quantity of 1' do
        post(:create, params: params)

        expect(Cart::Item.first.quantity).to eq(1)
      end
    end
  end

  describe 'PUT #update' do
    context 'with non-zero quantity' do
      let (:item) { Cart::Item.create!(product_id: 8) }
      let (:params) { { id: item.id, item: { quantity: 42 } } }

      it 'updates the existing item' do
        put(:update, params: params)
        expect(Cart::Item.find(item.id).quantity).to eq(42)
      end

      it 'renders cart with items and discounts' do
        put(:update, params: params)

        cart = JSON.parse(response.body)
        expect(cart['items'].size).to eq(1)
        expect(cart['discounts'].size).to eq(0)
      end
    end

    context 'with quantity of 0' do
      let (:item) { Cart::Item.create!(product_id: 8) }
      let (:params) { { id: item.id, item: { quantity: 0 } } }

      it 'removes the existing item' do
        put(:update, params: params)
        expect(Cart::Item.count).to eq(0)
      end
    end
  end
end
