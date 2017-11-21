# frozen_string_literal
require 'singleton'

class ProductCatalog
  include Singleton
  attr_reader :products

  Struct.new('Product', :code, :name, :price)

  HEADER = "Code         | Name                |  Price\n" \
           '-------------------------------------------------'.freeze
  DISPLAY_FORMAT = '%-13.13s| %-20.20s| %6.6s€'.freeze

  def initialize
    @products = {}
  end

  def get(code)
    products[code]
  end

  def add(code, name, price)
    products[code] = Struct::Product.new(code, name, price)
  end

  def remove(code)
    products.delete(code)
  end

  def display
    puts HEADER
    products.values.each { |product| display_row(product) }
  end

  def self.stub_product(code = 'FOO', name = 'Cabify Foo', price = 10.00)
    Struct::Product.new(code, name, price)
  end

  private

  def display_row(product)
    price = format('%.2f', product.price)
    puts format(DISPLAY_FORMAT, product.code, product.name, price)
  end
end
