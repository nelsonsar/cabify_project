require './models/product_catalog'
require './models/item'
Struct.new('DiscountItem', :code, :name, :quantity, :total)

class Checkout
  attr_reader :items, :catalog

  def initialize
    @items = {}
    @catalog = ProductCatalog.instance
  end

  def scan(product_code)
    product = catalog.get(product_code)
    return add_product(product) if product
    puts "#{product_code} is not in catalog."
  end

  def total
    items.values.sum(&:total)
  end

  def add_discount(item, quantity, total)
    discount_code = "DISCOUNT_#{item.code}"
    previous_discount = items[discount_code]
    if previous_discount.nil? || previous_discount.total.abs < total.abs
      items[discount_code] = Struct::DiscountItem.new(
        discount_code, item.name, quantity, -total)
    end
  end

  private

    def add_product(product)
      if (item = items[product.code])
        item.increment_quantity
      else
        items[product.code] = Item.new(product)
      end
    end
end
