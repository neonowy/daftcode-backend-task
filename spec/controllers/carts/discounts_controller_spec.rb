require 'rails_helper'

RSpec.describe Carts::DiscountsController, type: :controller do
  describe 'POST #create' do
    context 'with proper params' do
      let (:params) { { discount: {
        kind: :set,
        name: 'BBQ pack',
        product_ids: [4, 5, 5, 8],
        price: 11.99
      } } }

      it 'creates new discount' do
        post(:create, params: params)

        expect(CartDiscount.first.kind).to eq('set')
        expect(CartDiscount.first.name).to eq('BBQ pack')
        expect(CartDiscount.first.product_ids).to eq([4, 5, 5, 8])
        expect(CartDiscount.first.price).to eq(11.99)
      end

      it 'renders cart with items and discounts' do
        post(:create, params: params)

        cart = JSON.parse(response.body)
        expect(cart['items'].size).to eq(0)
        expect(cart['discounts'].size).to eq(1)
      end
    end
  end

  describe 'PUT #update' do
    context 'with proper params' do
      let (:discount) { CartDiscount.create!(kind: :set, name: 'BBQ pack', price: 9.99) }
      let (:params) { { id: discount.id, discount: { price: 19.99 } } }

      it 'updates the existing discount' do
        put(:update, params: params)
        expect(CartDiscount.find(discount.id).price).to eq(19.99)
      end

      it 'renders cart with items and discounts' do
        put(:update, params: params)

        cart = JSON.parse(response.body)
        expect(cart['items'].size).to eq(0)
        expect(cart['discounts'].size).to eq(1)
      end
    end
  end
end
