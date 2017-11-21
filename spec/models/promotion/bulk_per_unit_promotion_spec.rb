require './models/promotion/bulk_per_unit_promotion'

RSpec.describe BulkPerUnitPromotion do
  let(:bulk_promotion) { BulkPerUnitPromotion.new('FOO', 3, 19.00) }
  let(:checkout) { Checkout.new([bulk_promotion]) }

  before do
    ProductCatalog.instance.add('FOO', 'Cabify Foo', 20.00)
    ProductCatalog.instance.add('BAR', 'Cabify Bar', 5.00)
  end

  describe '#discount' do
    context 'when promoted product is not in items list' do
      it 'does not return any discount' do
        checkout.scan('BAR')
        checkout.scan('BAR')
        checkout.scan('BAR')

        discount = bulk_promotion.discount(checkout)
        expect(discount).to eq(nil)
      end
    end

    context 'when promoted products quantity is not enough for promotion' do
      it 'does not return any discount' do
        checkout.scan('FOO')
        checkout.scan('FOO')

        discount = bulk_promotion.discount(checkout)
        expect(discount).to eq(nil)
      end
    end

    context 'when there are three or more scanned promotional products' do
      it 'returns discount per unit' do
        checkout.scan('FOO')
        checkout.scan('FOO')
        checkout.scan('FOO')
        checkout.scan('FOO')

        discount = bulk_promotion.discount(checkout)
        expect(discount).not_to eq(nil)
        expect(discount.total).to eq(4.00)
        expect(discount.code).to eq('FOO')
      end
    end
  end
end
