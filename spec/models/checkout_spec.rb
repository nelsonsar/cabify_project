require './models/checkout'

RSpec.describe Checkout do
  let(:checkout) { Checkout.new }
  let(:product) { ProductCatalog.stub_product }
  let(:catalog) { ProductCatalog.instance }

  describe '#total' do
    context 'when there are no scanned items' do
      it 'returns 0.00' do
        expect(checkout.total).to eq(0.00)
      end
    end

    context 'when there are scanned items' do
      it 'returns the sum of quantity weighted prices' do
        allow(catalog).to receive(:get).with(product.code).and_return(product)
        checkout.scan(product.code)
        checkout.scan(product.code)

        expected_total = product.price * 2
        expect(checkout.total).to eq(expected_total)
      end
    end
  end

  describe '#scan' do
    context 'when the item is in catalog' do
      before do
        allow(catalog).to receive(:get).with(product.code).and_return(product)
      end

      it 'calls add on list of items' do
        expect(checkout.items).to receive(:add).with(product)

        checkout.scan(product.code)
      end

      context 'and not in the items list' do
        it 'adds product to items list' do
          checkout.scan(product.code)

          expect(checkout.items[product.code]).not_to eq(nil)
        end
      end

      context 'and in the items list' do
        it 'increments item quantity on items list' do
          checkout.scan(product.code)
          checkout.scan(product.code)

          item = checkout.items[product.code]
          expect(item.quantity).to eq(2)
        end
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
