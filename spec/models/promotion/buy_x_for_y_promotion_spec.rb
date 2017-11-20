require './models/promotion/buy_x_for_y_promotion'

RSpec.describe BuyXforYPromotion do
  let(:two_for_one) { BuyXforYPromotion.new('FOO', 2, 1) }
  let(:checkout) { Checkout.new([two_for_one]) }

  before do
    ProductCatalog.instance.add('FOO', 'Cabify Foo', 20.00)
    ProductCatalog.instance.add('BAR', 'Cabify Bar', 5.00)
  end

  describe '#get_discount' do
    context 'when promoted product is not in items list' do
      it 'does not return any discount' do
        checkout.scan('BAR')
        checkout.scan('BAR')
        checkout.scan('BAR')

        discount = two_for_one.get_discount(checkout)
        expect(discount).to eq(nil)
      end
    end

    context 'when promoted products quantity is not enough for promotion' do
      it 'does not return any discount' do
        checkout.scan('FOO')

        discount = two_for_one.get_discount(checkout)
        expect(discount).to eq(nil)
      end
    end

    context 'when promoted products quantity is enough for promotion' do
      it 'returns 2 for 1 discount' do
        checkout.scan('FOO')
        checkout.scan('FOO')
        checkout.scan('FOO')

        discount = two_for_one.get_discount(checkout)
        expect(discount).not_to eq(nil)
        expect(discount.total).to eq(20.00)
        expect(discount.code).to eq('FOO')
      end
    end
  end
end
