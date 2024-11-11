class PlaceOrderService
  def initialize(cart)
    raise Errors::NoCartError.new("No cart found") if cart.blank?
    @cart = cart
    @user = cart.user
  end

  def call
    raise Errors::CartAlreadyPlacedError, "Cart already placed" if @cart.status == :placed
    mark_cart_placed!
    make_order!
  end

  private

  def mark_cart_placed!
    @cart.update(status: :placed)
  end

  def make_order!
    order = create_order_with_total
    transfer_cart_items_to_order(order)

    order
  end

  def create_order_with_total
    total_amount = @cart.cart_items.sum do |item|
      item.product.display_price * item.qty
    end

    @cart.user.orders.create!(total_amt: total_amount.to_d)
  end

  def transfer_cart_items_to_order(order)
    @cart.cart_items.each do |cart_item|
      inventory_checker(cart_item.product, cart_item.qty).check_item_inventory!

      order.order_items.create!(
        product: cart_item.product,
        qty: cart_item.qty
      )
    end
  end

  def inventory_checker(product, qty)
    InventoryChecker.new(product, qty)
  end
end
