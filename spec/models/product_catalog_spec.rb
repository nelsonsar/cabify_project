require './models/product_catalog'

RSpec.describe ProductCatalog do
  let(:product) { ProductCatalog.stub_product }

  describe '.initialize' do
    it 'raises an error' do
      expect { ProductCatalog.new }.to raise_error(NoMethodError)
    end
  end

  describe '.add' do
    it 'adds product to catalog' do
      ProductCatalog.add(product.code, product.name, product.price)
      expect(ProductCatalog.instance.items[product.code]).not_to eq(nil)
    end
  end

  describe '.get' do
    context 'when product is in catalog' do
      it 'returns product' do
        ProductCatalog.add(product.code, product.name, product.price)
        product_retrived = ProductCatalog.get(product.code)
        expect(product_retrived).to eq(product)
      end
    end
  end

  describe '.stub_product' do
    it 'returns a stubbed foo product' do
      expect(product.code).to eq('FOO')
      expect(product.name).to eq('Cabify Foo')
      expect(product.price).to eq(10.00)
    end
  end

  describe '.remove' do
    it 'removes product from catalog' do
      ProductCatalog.remove('FOO')
      expect(ProductCatalog.instance.items['FOO']).to eq(nil)
    end
  end

  describe '.display' do
    it 'returns a table string with products on catalog' do
      ProductCatalog.remove('FOO')
      ProductCatalog.add('VOUCHER', 'Cabify Voucher', 5.00)
      ProductCatalog.add('TSHIRT', 'Cabify T-Shirt', 20.00)
      ProductCatalog.add('MUG', 'Cabify Coffee Mug', 7.50)
      expected_string = "Code         | Name                |  Price\n"
      expected_string << "-------------------------------------------------\n"
      expected_string << "VOUCHER      | Cabify Voucher      |   5.00€\n"
      expected_string << "TSHIRT       | Cabify T-Shirt      |  20.00€\n"
      expected_string << "MUG          | Cabify Coffee Mug   |   7.50€\n"
      expect { ProductCatalog.display }.to output(expected_string).to_stdout
    end
  end
end
