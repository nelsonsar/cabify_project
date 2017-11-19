require './models/product_catalog'
require './models/items_list'

class Checkout
  attr_reader :items

  def initialize
    @items = ItemsList.new
  end

  def total
    items.total
  end

  def scan(product_name)
    product = ProductCatalog.instance.get(product_name)
    return items.add(product) if product
    puts "#{product_name} is not in catalog."
  end

  def add_discount(item, quantity, total)
    items.add_discount(item, quantity, total)
  end
end
