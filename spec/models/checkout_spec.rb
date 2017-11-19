require './models/checkout'

RSpec.describe Checkout do
  let(:checkout) { Checkout.new }

  describe '#total' do
    it 'returns 0.00 if there are no scanned items' do
      expect(checkout.total).to eq(0.00)
    end
  end

  describe '#scan' do
    let(:product) { ProductCatalog.stub_product }

    context 'when the item is in catalog' do
      before do
        allow(ProductCatalog).to receive(:get).with(product.code)
                                              .and_return(product)
      end

      it 'calls add on list of items' do
        expect(checkout.items).to receive(:add).with(product)

        checkout.scan(product.code)
      end

      it 'adds product to items list' do
        checkout.scan(product.code)

        expect(checkout.items[product.code]).not_to eq(nil)
      end
    end

    context 'when the item is not in catalog' do
      it 'outputs unavailable message' do
        expect { checkout.scan(product.code) }
          .to output("#{product.code} is not in catalog.\n").to_stdout
      end

      it 'does not add product to items list' do
        checkout.scan(product.code)

        expect(checkout.items[product.code]).to eq(nil)
      end
    end
  end
end
