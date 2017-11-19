require 'singleton'

class ProductCatalog
  include Singleton

  attr_reader :items

  Struct.new('Product', :code, :name, :price)

  def initialize
    @items = {}
  end

  def self.get(code)
    instance.items[code]
  end

  def self.add(code, name, price)
    instance.items[code] = Struct::Product.new(code, name, price)
  end
end
