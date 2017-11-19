require './models/items_list'

RSpec.describe ItemsList do
  let(:product) { ProductCatalog.stub_product }
  let(:items_list) { ItemsList.new }

  describe '#[]' do
    context 'when the item is in the list' do
      it 'returns the item' do
        items_list.add(product)
        item = items_list[product.code]
        expect(item.class).to eq(Item)
      end
    end

    context 'when the item is not in the list' do
      it 'returns nil' do
        expect(items_list.items[product.code]).to eq(nil)
      end
    end
  end

  describe '#add' do
    context 'when product is not in list' do
      it 'adds item to list' do
        items_list.add(product)
        item = items_list.items[product.code]
        expect(item.quantity).to eq(1)
        expect(item.code).to eq(product.code)
        expect(item.name).to eq(product.name)
        expect(item.price).to eq(product.price)
      end
    end

    context 'when product is already in the list' do
      it 'increments quantity' do
        items_list.add(product)
        item = items_list.items[product.code]
        expect(item.quantity).to eq(1)
        items_list.add(product)
        expect(item.quantity).to eq(2)
      end
    end
  end

  describe '#total' do
    context 'when the list is empty' do
      it 'returns 0.00' do
        expect(items_list.total).to eq(0.00)
      end
    end

    context 'when the list is not empty' do
      it 'returns sum of items quantity weighted price' do
        items_list.add(product)
        items_list.add(product)
        expect(items_list.total).to eq(product.price * 2)
      end
    end
  end
end
