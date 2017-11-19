require './models/product_catalog'
require './models/items_list'

class Checkout
  attr_reader :items

  def initialize
    @items = ItemsList.new
  end

  def total
    0.00
  end

  def scan(product_name)
    product = ProductCatalog.get(product_name)
    return items.add(product) if product
    puts "#{product_name} is not in catalog."
  end
end
