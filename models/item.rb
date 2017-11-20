class Item
  extend Forwardable
  attr_reader :quantity, :product

  def_delegators :product, :code, :price, :name

  def initialize(product)
    @quantity = 1
    @product = product
  end

  def increment_quantity
    @quantity += 1
  end

  def total
    quantity * price
  end
end
