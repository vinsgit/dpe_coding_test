require 'rails_helper'

RSpec.describe Api::CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_cart).and_return(cart)
  end

  describe 'POST #add' do
    context 'when adding a product to the cart' do
      it 'adds the product to the cart' do
        post :add, params: { product_id: product.id, qty: 2, username: user.username, password: user.password }
        expect(response).to have_http_status(:ok)
        expect(cart.cart_items.count).to eq(1)
        expect(cart.cart_items.first.qty).to eq(2)
      end
    end
  end

  describe 'POST #place_order' do
    context 'when placing an order' do
      it 'places the order successfully' do
        cart_item
        post :place_order, params: { username: user.username, password: user.password }
        expect(response).to have_http_status(:ok)
        expect(cart.reload.status).to eq(:placed)
      end
    end
  end
end
