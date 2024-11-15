class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String

  has_many :products

  index({ name: 1 }, { unique: true })
end
