class DiscountItem
  extend Forwardable
  attr_reader :quantity, :product, :total

  def_delegators :product, :code, :price, :name

  def initialize(product, quantity, total)
    @quantity = 1
    @product = product
    @total = total
  end
end
