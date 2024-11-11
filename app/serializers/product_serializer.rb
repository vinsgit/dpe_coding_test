class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :qty, :price

  def category
    object.category&.name
  end

  def price
    object.display_price
  end
end
