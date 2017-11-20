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
    context 'when promoted products is not in items list' do
      it 'does not apply any discount' do
        expect { two_for_one.send(:apply, checkout) }
          .not_to change { checkout.total }
      end
    end

    context 'when promoted products quantity is not enough for promotion' do
      it 'does not apply any discount' do
        checkout.scan(product.code)
        expect { two_for_one.send(:apply, checkout) }.not_to change { checkout.total }
      end
    end

    context 'when promoted products quantity is enough for promotion' do
      it 'applies discount' do
        checkout.scan(product.code)
        checkout.scan(product.code)
        checkout.scan(product.code)

        price = product.price * 3
        price_with_discount = product.price * 2
        expect { two_for_one.send(:apply, checkout) }.to change { checkout.total }
          .from(price).to(price_with_discount)
      end
    end
  end
end
