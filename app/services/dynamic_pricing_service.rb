class DynamicPricingService
  LOW_INVENTORY_THRESHOLD = 10
  LOW_INVENTORY_PRICE_FACTOR = 1.2

  HIGH_INVENTORY_THRESHOLD = 100
  HIGH_INVENTORY_PRICE_FACTOR = 0.8

  DEMAND_CART_ITEM_FACTOR = 1.1
  DEMAND_ORDER_ITEM_FACTOR = 1.8

  COMPETITOR_PRICE_FACTOR = 0.9
  DEMAND_TIME_WINDOW = 1.week

  def initialize(product)
    @product = product
  end

  def modify_product_dynamic_price
    new_price = calculate_price(calculate_cart_item_demand, calculate_order_item_demand, @product.qty, latest_competitor_price)

    log_price_changing(new_price)

    @product.update(dynamic_price: new_price)
  end

  private

  def calculate_cart_item_demand
    CartItem.where(product: @product).where(created_at: DEMAND_TIME_WINDOW.ago..Time.current).sum(:qty)
  end

  def calculate_order_item_demand
    OrderItem.where(product: @product).where(created_at: DEMAND_TIME_WINDOW.ago..Time.current).sum(:qty)
  end

  def latest_competitor_price
    @product.competitor_prices.first&.price
  end

  def calculate_price(cart_item_demand, order_item_demand, inventory_level, competitor_price)
    base_price = @product.default_price

    if inventory_level <= LOW_INVENTORY_THRESHOLD
      base_price *= LOW_INVENTORY_PRICE_FACTOR
    elsif inventory_level >= HIGH_INVENTORY_THRESHOLD
      base_price *= HIGH_INVENTORY_PRICE_FACTOR
    end

    base_price += DEMAND_CART_ITEM_FACTOR * cart_item_demand
    base_price += DEMAND_ORDER_ITEM_FACTOR * order_item_demand

    if competitor_price && competitor_price < base_price
      base_price *= COMPETITOR_PRICE_FACTOR
    end

    base_price
  end

  def log_price_changing(new_price)
    PricingLog.create(
      product: @product,
      previous_price: @product.dynamic_price,
      new_price: new_price,
      reason: "Dynamic pricing calculation"
    )
  end
end