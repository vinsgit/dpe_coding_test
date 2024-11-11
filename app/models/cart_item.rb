class CartItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :qty, type: Integer, default: 1

  belongs_to :cart
  belongs_to :product

  validates :qty, presence: true, numericality: { greater_than_or_equal_to: 0 }

  index({ cart_id: 1 })
  index({ product_id: 1 })
end
