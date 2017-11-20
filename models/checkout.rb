require './models/product_catalog'
require './models/items_list'

class Checkout
  attr_reader :items, :catalog

  def initialize
    @items = ItemsList.new
    @catalog = ProductCatalog.instance
  end

  def total
    items.total
  end

  def scan(product_code)
    product = catalog.get(product_code)
    return items.add(product) if product
    puts "#{product_code} is not in catalog."
  end

  def add_discount(item, quantity, total)
    items.add_discount(item, quantity, total)
  end
end
