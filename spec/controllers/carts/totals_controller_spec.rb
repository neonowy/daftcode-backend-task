require 'rails_helper'

RSpec.describe Carts::TotalsController, type: :controller do
  describe 'GET #show' do
    context 'with sample cart items and discounts from README' do
      before do
        CartItem.create!(product_id: 5, quantity: 5) # 5 beers
        CartItem.create!(product_id: 8, quantity: 2) # 2 coals
        CartDiscount.create!(
          kind: :set,
          name: 'BBQ pack',
          product_ids: [4, 5, 5, 8], # sausage, beer, beer, coal
          price: 12.99
        )
        CartDiscount.create!(
          kind: :extra,
          name: 'Three for two',
          product_ids: [3, 5], # beer/mustard
          count: 2
        )
      end

      it 'chooses the best discounts' do
        get(:show)

        total = JSON.parse(response.body)
        expect(total['sets'][0]['name']).to eq('BBQ pack')
        expect(total['extras'][0]['name']).to eq('Three for two')
      end

      it 'calculates the regular price without discounts' do
        get(:show)

        total = JSON.parse(response.body)
        expect(total['regular_price']).to eq(34.0)
      end

      it 'shows regular products that left without any discount applied' do
        get(:show)

        total = JSON.parse(response.body)

        # 1 coal
        expect(total['regular_products'].size).to eq(1)
        expect(total['regular_products'][0]['id']).to eq(8)
      end
    end
  end
end
