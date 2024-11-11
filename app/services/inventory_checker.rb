class InventoryChecker
  def initialize(product, qty)
    @product = product
    @demand_qty = qty.to_i
  end

  def check_item_inventory!
    raise Errors::OutOfStockError, "#{@product.name} Out Of Stock" if @product.qty < @demand_qty
  end
end
