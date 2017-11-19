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

  def self.stub_product
    Struct::Product.new('FOO', 'Cabify Foo', 10.00)
  end

  def get(code)
    items[code]
  end

  def add(code, name, price)
    items[code] = Struct::Product.new(code, name, price)
  end

  def remove(code)
    items.delete(code)
  end

  def display
    puts HEADER
    items.values.each do |item|
      price = format('%.2f', item.price)
      puts format(DISPLAY_FORMAT, item.code, item.name, price)
    end
  end
end
