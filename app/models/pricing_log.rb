class PricingLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :product_id, type: BSON::ObjectId
  field :previous_price, type: BigDecimal
  field :new_price, type: BigDecimal
  field :reason, type: String

  belongs_to :product

  index({ product_id: 1 })

  validates :previous_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :new_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :reason, presence: true
end
