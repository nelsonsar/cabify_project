class Item
  extend Forwardable
  attr_reader :quantity, :product

  def_delegators :product, :code, :price, :name

  def initialize(product, quantity = 1, total = nil)
    @quantity = quantity
    @product = product
    @total = total
  end

  def increment_quantity
    @quantity += 1
  end

  def total
    @total || (quantity * price)
  end
end
