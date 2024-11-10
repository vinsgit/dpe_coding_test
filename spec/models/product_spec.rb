require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { create(:category) }

  it 'is valid with valid attributes' do
    product = build(:product, category: category)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = build(:product, name: nil, category: category)
    expect(product).to_not be_valid
  end

  it 'is not valid with negative qty' do
    product = build(:product, qty: -1, category: category)
    expect(product).to_not be_valid
  end

  it 'is not valid without default_price' do
    product = build(:product, default_price: nil, category: category)
    expect(product).to_not be_valid
  end

  it 'is not valid with negative default_price' do
    product = build(:product, default_price: -1.0, category: category)
    expect(product).to_not be_valid
  end

  it 'is valid with nil dynamic_price' do
    product = build(:product, dynamic_price: nil, category: category)
    expect(product).to be_valid
  end

  it 'is valid with nil demand_factor' do
    product = build(:product, demand_factor: nil, category: category)
    expect(product).to be_valid
  end
end
