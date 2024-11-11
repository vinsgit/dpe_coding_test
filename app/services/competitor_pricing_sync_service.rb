# frozen_string_literal: true

class CompetitorPricingSyncService
  BASE_URL = 'https://sinatra-pricing-api.fly.dev/prices'
  API_KEY = 'demo123'

  def call
    response = fetch_competitor_price

    return unless response.code == 200

    response.each do |item|
      product = Product.where(name: item['name']).first

      next unless product

      product.competitor_prices.create(price: item['price'], competitor_name: 'fly')
    end
  end

  private

  def fetch_competitor_price
    api_key = URI.encode_www_form({ api_key: API_KEY })

    response = HTTParty.get("#{BASE_URL}?#{api_key}")
    
    Rails.logger.error "Failed to fetch competitor price: #{response.message}" if response.code != 200
    
    response
  end
end
