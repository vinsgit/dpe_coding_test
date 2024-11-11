# spec/models/pricing_log_spec.rb

require 'rails_helper'

RSpec.describe PricingLog, type: :model do
  let(:product) { create(:product) }
  let(:pricing_log) { build(:pricing_log, product: product) }

  it 'is valid with valid attributes' do
    expect(pricing_log).to be_valid
  end

  it 'is not valid without a previous_price' do
    pricing_log.previous_price = nil
    expect(pricing_log).not_to be_valid
  end

  it 'is not valid without a new_price' do
    pricing_log.new_price = nil
    expect(pricing_log).not_to be_valid
  end

  it 'is not valid without a reason' do
    pricing_log.reason = nil
    expect(pricing_log).not_to be_valid
  end

  it 'is not valid with a negative previous_price' do
    pricing_log.previous_price = -1
    expect(pricing_log).not_to be_valid
  end

  it 'is not valid with a negative new_price' do
    pricing_log.new_price = -1
    expect(pricing_log).not_to be_valid
  end
end
