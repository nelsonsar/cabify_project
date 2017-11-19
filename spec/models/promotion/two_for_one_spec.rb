require './models/promotion'
require './models/promotion/two_for_one'

RSpec.describe TwoForOne do
  let(:product) { ProductCatalog.stub_product }
  let(:two_for_one) { TwoForOne.new(product.code) }
  let(:checkout) { Checkout.new }

  before do
    ProductCatalog.instance.add(product.code, product.name, product.price)
  end

  describe '#apply' do
    context 'when promotion is not appliable' do
      it 'does nothing' do
        expect { two_for_one.apply(checkout) }.not_to change { checkout.total }
      end
    end

    context 'when there is one scanned promotional product' do
      it 'does nothing' do
        checkout.scan(product.code)
        expect { two_for_one.apply(checkout) }.not_to change { checkout.total }
      end
    end

    context 'when there are more than one scanned promotional product' do
      it 'applies two for one discount' do
        checkout.scan(product.code)
        checkout.scan(product.code)
        checkout.scan(product.code)
        expect { two_for_one.apply(checkout) }.to change { checkout.total }
          .from(product.price * 3).to(product.price * 2)
      end
    end
  end
end
