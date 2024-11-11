class OrderItemService
  def initialize(order_item)
    @order_item = order_item
    @product = order_item.product
  end

  def deduct_product_qty
    if @product.qty >= @order_item.qty
      @product.qty -= @order_item.qty
      @product.save!
    else
      raise Errors::OutOfStockError, "Insufficient stock for product #{@product.name}"
    end
  end
end
