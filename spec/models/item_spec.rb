require './models/item'

RSpec.describe Item do
  let(:product) { ProductCatalog.stub_product }
  let(:item) { Item.new(product) }

  describe '.initialize' do
    it 'instantiates item with quantity one and with products attributes' do
      expect(item.quantity).to eq(1)
      expect(item.price).to eq(product.price)
      expect(item.name).to eq(product.name)
      expect(item.code).to eq(product.code)
    end
  end

  describe '#incremente_quantity' do
    it 'adds item to list' do
      expect { item.increment_quantity }.to change { item.quantity }
        .from(1).to(2)
    end
  end

  describe '#total' do
    it 'multiplies price by quantity' do
      item.increment_quantity
      item.increment_quantity
      expect(item.total).to eq(3 * product.price)
    end
  end
end
