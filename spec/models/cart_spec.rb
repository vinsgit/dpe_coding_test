require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'is valid with valid attributes' do
    cart = build(:cart)
    expect(cart).to be_valid
  end

  it 'is not valid without a status' do
    cart = build(:cart, status: nil)
    expect(cart).to_not be_valid
  end

  it 'is not valid with an invalid status' do
    cart = build(:cart, status: :invalid_status)
    expect(cart).to_not be_valid
  end
end
