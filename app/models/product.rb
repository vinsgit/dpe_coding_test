class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :qty, type: Integer, default: 0
  field :default_price, type: Float
  field :dynamic_price, type: Float
  field :demand_factor, type: Float, default: 1.0

  belongs_to :category

  has_many :competitor_prices
  has_many :order_items

  validates :name, presence: true
  validates :qty, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :default_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
