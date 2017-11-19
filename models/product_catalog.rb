# frozen_string_literal

require 'singleton'

class ProductCatalog
  include Singleton

  attr_reader :items

  Struct.new('Product', :code, :name, :price)

  HEADER = "Code         | Name                |  Price\n" \
           '-------------------------------------------------'.freeze
  DISPLAY_FORMAT = '%-13.13s| %-20.20s| %6.6s€'.freeze

  def initialize
    @items = {}
  end

  def self.get(code)
    instance.items[code]
  end

  def self.add(code, name, price)
    instance.items[code] = Struct::Product.new(code, name, price)
  end

  def self.remove(code)
    instance.items.delete(code)
  end

  def self.stub_product
    Struct::Product.new('FOO', 'Cabify Foo', 10.00)
  end

  def self.display
    puts HEADER
    instance.items.values.each do |item|
      price = format('%.2f', item.price)
      puts format(DISPLAY_FORMAT, item.code, item.name, price)
    end
  end
end
