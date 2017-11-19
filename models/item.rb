class Item
  attr_reader :quantity

  def initialize(p)
    @quantity = 1
  end

  def increment_quantity
    @quantity += 1
  end
end
