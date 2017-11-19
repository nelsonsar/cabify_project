class Item < SimpleDelegator
  attr_reader :quantity

  def initialize(product)
    @quantity = 1
    super(product)
  end

  def increment_quantity
    @quantity += 1
  end

  def total
    quantity * price
  end
end
