require 'rails_helper'

RSpec.describe CurrentCartService do
  let(:user) { create(:user) }
  let!(:cart) { create(:cart, user: user, status: :ongoing) }

  describe '#call' do
    it 'returns the current ongoing cart for the user' do
      service = CurrentCartService.new(user)
      current_cart = service.call
      expect(current_cart).to eq(cart)
    end
  end
end
