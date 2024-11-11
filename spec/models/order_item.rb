require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it 'is valid with valid attributes' do
    order_item = build(:order_item)
    expect(order_item).to be_valid
  end

  it 'is not valid without a quantity' do
    order_item = build(:order_item, qty: nil)
    expect(order_item).to_not be_valid
  end

  it 'is not valid with a negative quantity' do
    order_item = build(:order_item, qty: -1)
    expect(order_item).to_not be_valid
  end
end
