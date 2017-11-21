require './models/item'

RSpec.describe Item do
  let(:product) { ProductCatalog.stub_product }
  let(:item) { Item.new(product) }

  describe '.initialize' do
    context 'with default parameters' do
      it 'instantiates item with quantity one and with products attributes' do
        expect(item.quantity).to eq(1)
        expect(item.price).to eq(product.price)
        expect(item.name).to eq(product.name)
        expect(item.code).to eq(product.code)
      end
    end

    context 'with specified parameters' do
      it 'instantiates item with specified quantity and total' do
        item = Item.new(product, 10, 20.00)
        expect(item.quantity).to eq(10)
        expect(item.price).to eq(product.price)
        expect(item.name).to eq(product.name)
        expect(item.code).to eq(product.code)
        expect(item.total).to eq(20.00)
      end
    end
  end

  describe '#incremente_quantity' do
    it 'adds item to list' do
      expect { item.increment_quantity }.to change { item.quantity }
        .from(1).to(2)
    end
  end

  describe '#total' do
    context 'when default initialization' do
      it 'multiplies price by quantity' do
        item.increment_quantity
        item.increment_quantity
        expect(item.total).to eq(3 * product.price)
      end
    end
    context 'with total specified on initialization' do
      it 'returns the specified value' do
        item = Item.new(product, 10, 20.00)
        expect(item.total).not_to eq(product.price * 10)
        expect(item.total).to eq(20.00)
      end
    end
  end
end
