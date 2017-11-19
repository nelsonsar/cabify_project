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
    items[product.code] = Item.new(p)
  end
end
