class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :total_amt, type: BigDecimal, default: 0.0

  has_many :order_items
  belongs_to :user

  index({ user_id: 1 })
end
