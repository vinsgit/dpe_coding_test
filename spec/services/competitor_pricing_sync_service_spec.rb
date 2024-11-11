require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CompetitorPricingSyncService do
  describe '#call' do
    let(:service) { described_class.new }
    let(:product_name) { 'Test Product' }
    let(:product) { create(:product, name: product_name) }

    context 'when the API request is successful' do
      let(:competitor_data) do
        [
          { 'name' => product_name, 'price' => 100.0, 'category' => 'Test Category', 'qty' => 100 },
          { 'name' => 'Another Product', 'price' => 150.0, 'category' => 'Test Category', 'qty' => 100 }
        ]
      end

      before do
        stub_request(:get, "#{CompetitorPricingSyncService::BASE_URL}?api_key=#{CompetitorPricingSyncService::API_KEY}")
          .to_return(status: 200, body: competitor_data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it 'creates competitor prices for matching products' do
        expect { service.call }.to change { product.competitor_prices.count }.by(1)

        created_price = product.competitor_prices.last
        expect(created_price.price).to eq(100.0)
        expect(created_price.competitor_name).to eq('fly')
      end
    end

    context 'when the API request fails' do
      before do
        stub_request(:get, "#{CompetitorPricingSyncService::BASE_URL}?api_key=#{CompetitorPricingSyncService::API_KEY}")
          .to_return(status: 500, body: '', headers: { 'Content-Type' => 'application/json' })
      end

      it 'does not create any competitor prices' do
        expect { service.call }.not_to change { CompetitorPrice.count }
      end

      it 'logs an error message' do
        expect(Rails.logger).to receive(:error)
        service.call
      end
    end
  end
end
