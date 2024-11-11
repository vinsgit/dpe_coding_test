require 'rails_helper'

RSpec.describe AddToCartService do
  let(:user) { create(:user) }
  let(:product) { create(:product, qty: 100) }
  let(:cart) { create(:cart, user: user) }

  describe '#call' do
    context 'when adding a new product to the cart' do
      it 'creates a new cart item' do
        service = AddToCartService.new(cart, product.id, 2)
        service.call
        expect(cart.cart_items.count).to eq(1)
        expect(cart.cart_items.first.product).to eq(product)
        expect(cart.cart_items.first.qty).to eq(2)
      end
    end

    context 'when adding an existing product to the cart' do
      let!(:cart_item) { create(:cart_item, cart: cart, product: product, qty: 1) }

      it 'updates the quantity of the existing cart item' do
        service = AddToCartService.new(cart, product.id, 2)
        service.call
        expect(cart.reload.cart_items.count).to eq(1)
        expect(cart.reload.cart_items.first.qty).to eq(3)
      end
    end

    context 'when the product is out of stock' do
      let(:product) { create(:product, qty: 1) }

      it 'raises an OutOfStockError' do
        service = AddToCartService.new(cart, product.id, 2)
        expect { service.call }.to raise_error(Errors::OutOfStockError)
      end
    end
  end
end
