class AddToCartService

  def initialize(cart, product_id, qty)
    @cart = cart
    @item = cart.cart_items.where(product_id: product_id).first
    @product = Product.find(product_id)
    @qty = qty.to_i + @item&.qty.to_i
  end

  def call
    stock_checker.check_item_inventory!
    update_item || create_item
  end

  private

  def stock_checker
    @stock_checker ||= InventoryChecker.new(@product, @qty)
  end

  def item
    @cart.cart_items.where(product_id: @product.id).first
  end

  def create_item
    @cart.cart_items.create(product_id: @product.id, qty: @qty)
  end

  def update_item
    item&.update(qty: @qty)
  end
end
