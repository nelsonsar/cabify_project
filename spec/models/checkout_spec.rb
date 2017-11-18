RSpec.describe Checkout do
  describe '#total' do
    it 'returns 0.00€ if there are no scanned items' do
      co = Checkout.new
      expect(co.total).to eq(0.00)
    end
  end
end
