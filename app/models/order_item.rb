class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :qty, type: Integer, default: 1

  belongs_to :order
  belongs_to :product

  before_save :deduct_product_qty

  index({ order_id: 1 })
  index({ product_id: 1 })

  private

  def deduct_product_qty
    OrderItemService.new(self).deduct_product_qty
  end
end
