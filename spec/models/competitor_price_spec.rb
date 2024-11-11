# spec/models/competitor_price_spec.rb

require 'rails_helper'

RSpec.describe CompetitorPrice, type: :model do
  let(:product) { create(:product) }
  let(:competitor_price) { build(:competitor_price, product: product) }

  it 'is valid with valid attributes' do
    expect(competitor_price).to be_valid
  end

  it 'is not valid without a competitor_name' do
    competitor_price.competitor_name = nil
    expect(competitor_price).not_to be_valid
  end

  it 'is not valid without a price' do
    competitor_price.price = nil
    expect(competitor_price).not_to be_valid
  end

  it 'is not valid with a negative price' do
    competitor_price.price = -1
    expect(competitor_price).not_to be_valid
  end
end
