require './models/item'

class ItemsList
  attr_reader :items

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

  def total
    items.values.sum(&:total)
  end
end
