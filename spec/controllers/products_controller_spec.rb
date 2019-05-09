require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it 'renders all the products in json' do
      get :index
      expect(JSON.parse(response.body).size).to eq(Product.count)
    end
  end
end
