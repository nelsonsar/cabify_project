class BulkPerUnitPromotion < Promotion
  attr_reader :product_code, :min_units, :per_unit_price

  def initialize(product_code, min_units, per_unit_price)
    @product_code = product_code
    @min_units = min_units
    @per_unit_price = per_unit_price
  end

  def apply(checkout)
    item = checkout.items[product_code]
    return unless appliable?(item)
    total_discount = discount(item)
    checkout.add_discount(item, item.quantity, total_discount)
  end

  private

  def appliable?(item)
    item && item.quantity >= min_units
  end

  def discount(item)
    item.total - (item.quantity * per_unit_price)
  end
end
