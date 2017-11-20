require './models/promotion'
require './models/promotion/buy_x_for_y_promotion'

RSpec.describe BuyXforYPromotion do
  let(:product) { ProductCatalog.stub_product }
  let(:two_for_one) { BuyXforYPromotion.new(product.code, 2, 1) }
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