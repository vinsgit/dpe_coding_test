class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :qty, :price

  def category
    object.category&.name
  end

  def price
    object.dynamic_price.presence || object.default_price
  end
end
