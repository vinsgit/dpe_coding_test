class CartSerializer < ActiveModel::Serializer
  attributes :id, :status

  has_many :cart_items

  def id
    object.id.to_s
  end

  def cart_items
    object.cart_items.map do |cart_item|
      {
        item: cart_item.product.name,
        qty: cart_item.qty
      }
    end
  end
end
