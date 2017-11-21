require './models/checkout'
require './models/promotion/bulk_per_unit_promotion'
require './models/promotion/buy_x_for_y_promotion'

RSpec.describe Checkout do
  let(:checkout) { Checkout.new }
  let(:catalog) { ProductCatalog.instance }

  before do
    catalog.add('FOO', 'Cabify Foo', 10.00)
  end

  describe '#total' do
    context 'when there are no scanned items' do
      it 'returns 0.00' do
        expect(checkout.total).to eq(0.00)
      end
    end

    context 'when there are scanned items' do
      it 'returns the sum of quantity weighted prices' do
        checkout.scan('FOO')
        checkout.scan('FOO')

        expect(checkout.total).to eq(20.00)
      end
    end

    context 'when there are promotions' do
      let(:two_for_one) { BuyXforYPromotion.new('VOUCHER', 2, 1) }
      let(:bulk_discount) { BulkPerUnitPromotion.new('TSHIRT', 3, 19.00) }
      let(:checkout) { Checkout.new([two_for_one, bulk_discount]) }

      before do
        catalog.add('VOUCHER', 'Cabify Voucher', 5.00)
        catalog.add('TSHIRT', 'Cabify T-Shirt', 20.00)
        catalog.add('MUG', 'Cabify Mug', 7.50)
      end

      context 'but they are not applicable' do
        it 'returns the sum of quantity weighted prices' do
          checkout.scan('VOUCHER')
          checkout.scan('TSHIRT')
          checkout.scan('MUG')

          expect(checkout.total).to eq(32.50)
        end
      end

      context 'and two for one promotion is applicable' do
        it 'applies discount' do
          checkout.scan('VOUCHER')
          checkout.scan('TSHIRT')
          checkout.scan('VOUCHER')

          expect(checkout.total).to eq(25.00)
        end
      end

      context 'and bulk promotion is applicable' do
        it 'applies discount' do
          checkout.scan('TSHIRT')
          checkout.scan('TSHIRT')
          checkout.scan('TSHIRT')
          checkout.scan('VOUCHER')
          checkout.scan('TSHIRT')

          expect(checkout.total).to eq(81.00)
        end
      end

      context 'and more than one promotion is applicable' do
        it 'applies multiple discounts' do
          checkout.scan('VOUCHER')
          checkout.scan('TSHIRT')
          checkout.scan('VOUCHER')
          checkout.scan('VOUCHER')
          checkout.scan('MUG')
          checkout.scan('TSHIRT')
          checkout.scan('TSHIRT')

          expect(checkout.total).to eq(74.50)
        end
      end
    end
  end

  describe '#scan' do
    context 'when the product is in catalog' do
      context 'and not in the items list' do
        it 'adds product to items list' do
          checkout.scan('FOO')

          expect(checkout.items['FOO']).not_to eq(nil)
        end
      end

      context 'and in the items list' do
        it 'increments items quantity' do
          checkout.scan('FOO')
          item = checkout.items['FOO']

          expect(item.quantity).to eq(1)

          checkout.scan('FOO')

          expect(item.quantity).to eq(2)
        end
      end
    end

    context 'when the item is not in catalog' do
      it 'outputs unavailable message' do
        expect { checkout.scan('BAR') }
          .to output("BAR is not in catalog.\n").to_stdout
      end

      it 'does not add product to items list' do
        checkout.scan('BAR')

        expect(checkout.items['BAR']).to eq(nil)
      end
    end
  end
end
