require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    before do
      Cart::Item.create!(product_id: 1)
      Cart::Item.create!(product_id: 2)
    end

    it 'renders cart with items and discounts' do
      get(:show)

      cart = JSON.parse(response.body)
      expect(cart['items'].size).to eq(2)
      expect(cart['discounts'].size).to eq(0)
    end
  end
end
