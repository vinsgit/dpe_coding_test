class DynamicPricingJob
  include Sidekiq::Job

  def perform
    Product.all.each do |product|
      DynamicPricingService.new(product).modify_product_dynamic_price
    end
  end
end
