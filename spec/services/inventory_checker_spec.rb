require 'rails_helper'

RSpec.describe InventoryChecker do
  let(:product) { create(:product, qty: 10) }

  describe '#check_item_inventory!' do
    context 'when there is enough stock' do
      it 'does not raise an error' do
        checker = InventoryChecker.new(product, 5)
        expect { checker.check_item_inventory! }.not_to raise_error
      end
    end

    context 'when there is not enough stock' do
      it 'raises an OutOfStockError' do
        checker = InventoryChecker.new(product, 15)
        expect { checker.check_item_inventory! }.to raise_error(Errors::OutOfStockError)
      end
    end
  end
end
