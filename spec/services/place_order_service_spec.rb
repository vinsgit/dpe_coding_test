require 'rails_helper'

RSpec.describe PlaceOrderService do
  let(:user) { create(:user) }
  let(:product) { create(:product, default_price: 10.0, qty:100) }
  let(:cart) { create(:cart, user: user) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product, qty: 2) }

  before do
    cart_item
  end

  describe '#call' do
    context 'when cart is valid' do
      it 'marks the cart as placed' do
        service = PlaceOrderService.new(cart)
        service.call
        expect(cart.reload.status).to eq(:placed)
      end

      it 'creates an order with the correct total amount' do
        service = PlaceOrderService.new(cart)
        order = service.call
        expect(order.total_amt).to eq(20.0)
      end

      it 'transfers cart items to order items' do
        service = PlaceOrderService.new(cart)
        order = service.call
        expect(order.order_items.count).to eq(1)
        expect(order.order_items.first.product).to eq(product)
        expect(order.order_items.first.qty).to eq(2)
      end
    end

    context 'when cart is already placed' do
      it 'raises CartAlreadyPlacedError' do
        cart.update(status: :placed)
        service = PlaceOrderService.new(cart)
        expect { service.call }.to raise_error(Errors::CartAlreadyPlacedError)
      end
    end

    context 'when cart is not found' do
      it 'raises NoCartError' do
        expect { PlaceOrderService.new(nil) }.to raise_error(Errors::NoCartError)
      end
    end
  end
end
