class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :qty, type: Integer, default: 0
  field :default_price, type: BigDecimal
  field :dynamic_price, type: BigDecimal

  belongs_to :category

  has_many :competitor_prices
  has_many :pricing_logs
  has_many :order_items

  validates :name, presence: true
  validates :qty, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :default_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  index({ category_id: 1 })
  index({ name: 1 })

  def display_price
    (dynamic_price || default_price).round(2)
  end
end
