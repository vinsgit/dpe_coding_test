class CompetitorPrice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :competitor_name, type: String
  field :price, type: BigDecimal

  belongs_to :product, inverse_of: :competitor_prices

  index({ product_id: 1 })
  index({ competitor_name: 1, created_at: -1 })

  validates :competitor_name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
