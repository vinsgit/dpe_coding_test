require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it 'is valid with valid attributes' do
    cart_item = build(:cart_item)
    expect(cart_item).to be_valid
  end

  it 'is not valid without a quantity' do
    cart_item = build(:cart_item, qty: nil)
    expect(cart_item).to_not be_valid
  end

  it 'is not valid with a negative quantity' do
    cart_item = build(:cart_item, qty: -1)
    expect(cart_item).to_not be_valid
  end
end
