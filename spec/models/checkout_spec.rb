require './models/checkout'

RSpec.describe Checkout do
  describe '#total' do
    it 'returns 0.00€ if there are no scanned items' do
      co = Checkout.new
      expect(co.total).to eq(0.00)
    end
  end

  describe '#scan' do
    Struct.new('Product', :code, :name, :price)
    let(:checkout) { Checkout.new }
    let(:product) { Struct::Product.new('FOO', 'Cabify Foo', 10.00) }

    context 'when the item is in catalog' do
      it 'calls add on list of items' do
        allow(ProductCatalog).to receive(:get).with('FOO').and_return(product)

        expect(checkout.items).to receive(:add).with(product)
        checkout.scan('FOO')
      end

      it 'adds product to items list' do
        allow(ProductCatalog).to receive(:get).with('FOO').and_return(product)

        checkout.scan('FOO')

        expect(checkout.items['FOO']).not_to eq(nil)
      end
    end

    context 'when the item is not in catalog' do
      it 'outputs unavailable message' do
        expect { checkout.scan('FOO') }
          .to output("FOO is not in catalog.\n").to_stdout
      end

      it 'does not add product to items list' do
        checkout.scan('FOO')

        expect(checkout.items['FOO']).to eq(nil)
      end
    end
  end
end
