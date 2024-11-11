# spec/services/dynamic_pricing_service_spec.rb

require 'rails_helper'

RSpec.describe DynamicPricingService, type: :service do
  let(:product) { create(:product, default_price: 100, dynamic_price: 100, qty: 50) }
  let(:service) { DynamicPricingService.new(product) }

  describe '#modify_product_dynamic_price' do
    before do
      allow(service).to receive(:calculate_cart_item_demand).and_return(cart_item_demand)
      allow(service).to receive(:calculate_order_item_demand).and_return(order_item_demand)
      allow(service).to receive(:latest_competitor_price).and_return(competitor_price)
    end

    let(:cart_item_demand) { 0 }
    let(:order_item_demand) { 0 }
    let(:competitor_price) { nil }

    context 'when inventory is low' do
      before { product.update(qty: 5) }

      it 'increases the price' do
        expect { service.modify_product_dynamic_price }.to change { product.reload.dynamic_price }.by(20)
      end
    end

    context 'when inventory is high' do
      before { product.update(qty: 150) }

      it 'decreases the price' do
        expect { service.modify_product_dynamic_price }.to change { product.reload.dynamic_price }.by(-20)
      end
    end

    context 'when there is high cart item demand' do
      let(:cart_item_demand) { 10 }

      it 'increases the price based on cart item demand' do
        expect { service.modify_product_dynamic_price }.to change { product.reload.dynamic_price }.by(11)
      end
    end

    context 'when there is high order item demand' do
      let(:order_item_demand) { 10 }

      it 'increases the price based on order item demand' do
        expect { service.modify_product_dynamic_price }.to change { product.reload.dynamic_price }.by(18)
      end
    end

    context 'when competitor price is lower' do
      let(:competitor_price) { 80 }

      it 'adjusts the price based on competitor price' do
        expect { service.modify_product_dynamic_price }.to change { product.reload.dynamic_price }.to(90)
      end
    end

    context 'when logging price changes' do
      it 'creates a pricing log' do
        expect { service.modify_product_dynamic_price }.to change { PricingLog.count }.by(1)
      end

      it 'logs the correct price change reason' do
        service.modify_product_dynamic_price
        log = PricingLog.last
        expect(log.reason).to eq('Dynamic pricing calculation')
      end
    end
  end
end
