require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    before do
      CartItem.create!(product_id: 1)
      CartItem.create!(product_id: 2)
      CartDiscount.create!(kind: :set, name: 'BBQ pack', price: 19.99)
    end

    it 'renders cart with items and discounts' do
      get(:show)

      cart = JSON.parse(response.body)
      expect(cart['items'].size).to eq(2)
      expect(cart['discounts'].size).to eq(1)
    end
  end
end
