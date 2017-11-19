require './models/checkout'

RSpec.describe Checkout do
  describe '#total' do
    it 'returns 0.00€ if there are no scanned items' do
      co = Checkout.new
      expect(co.total).to eq(0.00)
    end
  end

  describe '#scan' do
    context 'when the item is in catalog' do
      it 'calls add on list of items' do
        p = double
        allow(ProductCatalog).to receive(:get).with('FOO').and_return(p)

        co = Checkout.new

        expect(co.items).to receive(:add).with(p)
        co.scan('FOO')
      end
    end

    context 'when the item is not in catalog' do
      it 'outputs unavailable message' do
        co = Checkout.new
        expect { co.scan('FOO') }.to output("FOO is not in catalog.\n")
          .to_stdout
      end
    end
  end
end
