require 'rails_helper'

RSpec.describe OrderItemService do
  let(:product) { instance_double('Product', qty: 10) }
  let(:order_item) { instance_double('OrderItem', product: product, qty: 5) }

  before do
    allow(product).to receive(:save!)
    allow(product).to receive(:name)
    allow(product).to receive(:qty=)
    allow(order_item).to receive(:product).and_return(product)
  end

  describe '#deduct_product_qty' do
    context 'when there is enough stock' do
      it 'deducts the product quantity' do
        service = OrderItemService.new(order_item)
        service.deduct_product_qty
        expect(product).to have_received(:qty=).with(5)
        expect(product).to have_received(:save!)
      end
    end

    context 'when there is not enough stock' do
      let(:order_item) { instance_double('OrderItem', product: product, qty: 15) }

      it 'raises an OutOfStockError' do
        service = OrderItemService.new(order_item)
        expect { service.deduct_product_qty }.to raise_error(Errors::OutOfStockError)
      end
    end
  end
end
