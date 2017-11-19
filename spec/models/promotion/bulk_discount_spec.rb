require './models/promotion'
require './models/promotion/bulk_discount'

RSpec.describe BulkDiscount do
  let(:product) { ProductCatalog.stub_product }
  let(:bulk_discount) { BulkDiscount.new(product.code, 3, 19.00) }
  let(:checkout) { Checkout.new }

  before do
    ProductCatalog.instance.add(product.code, product.name, product.price)
  end

  describe '#apply' do
    context 'when promotion is not appliable' do
      it 'does nothing' do
        expect { bulk_discount.apply(checkout) }.not_to change { checkout.total }
      end
    end

    context 'when there are two scanned promotional product' do
      it 'does nothing' do
        checkout.scan(product.code)
        checkout.scan(product.code)
        expect { bulk_discount.apply(checkout) }.not_to change { checkout.total }
      end
    end

    context 'when there are three or more scanned promotional product' do
      it 'applies discount per unit' do
        checkout.scan(product.code)
        checkout.scan(product.code)
        checkout.scan(product.code)
        checkout.scan(product.code)
        expect { bulk_discount.apply(checkout) }.to change { checkout.total }
          .from(product.price * 4).to(19.00 * 4)
      end
    end
  end
end
