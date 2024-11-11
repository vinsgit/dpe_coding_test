require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'is valid with valid attributes' do
    order = build(:order)
    expect(order).to be_valid
  end

  it 'is not valid without a total amount' do
    order = build(:order, total_amt: nil)
    expect(order).to_not be_valid
  end
end
