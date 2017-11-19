RSpec.describe ProductCatalog do
  describe '.initialize' do
    it 'raises an error' do
      expect { ProductCatalog.new }.to raise_error(NoMethodError)
    end
  end

  describe '#add' do
    it 'adds product to catalog' do
      code = 'FOO'
      name = 'Cabify Foo'
      price = 10.00
      ProductCatalog.add(code, name, price)
      expect(ProductCatalog.instance.items['FOO']).not_to eq(nil)
    end
  end

  describe '#get' do
    context 'when product is in catalog' do
      it 'returns product' do
        code = 'FOO'
        name = 'Cabify Foo'
        price = 10.00
        ProductCatalog.add(code, name, price)
        product = ProductCatalog.get('FOO')
        expect(product.code).to eq('FOO')
        expect(product.name).to eq('Cabify Foo')
        expect(product.price).to eq(10.00)
      end
    end
  end
end
