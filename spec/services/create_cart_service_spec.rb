require 'rails_helper'

RSpec.describe CreateCartService do
  let(:user) { create(:user) }

  describe '#call' do
    it 'creates a new cart for the user' do
      service = CreateCartService.new(user)
      cart = service.call
      expect(cart).to be_persisted
      expect(cart.user).to eq(user)
      expect(cart.status).to eq(:ongoing)
    end
  end
end
