require './models/item'

class ItemsList
  attr_reader :items
  Struct.new('DiscountItem', :code, :name, :quantity, :total)

  def initialize
    @items = {}
  end

  def [](value)
    items[value]
  end

  def add(product)
    if (item = items[product.code])
      item.increment_quantity
    else
      items[product.code] = Item.new(product)
    end
  end

  def add_discount(item, quantity, total)
    discount_code = "DISCOUNT_#{item.code}"
    previous_discount = items[discount_code]
    if previous_discount.nil? || previous_discount.total.abs < total.abs
      items[discount_code] = Struct::DiscountItem.new(
        discount_code, item.name, quantity, -total)
    end
  end

  def total
    items.values.sum(&:total)
  end
end
