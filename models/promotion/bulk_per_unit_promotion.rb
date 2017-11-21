require './models/promotion'

class BulkPerUnitPromotion < Promotion
  attr_reader :product_code, :min_units, :per_unit_price

  def initialize(product_code, min_units, per_unit_price)
    @product_code = product_code
    @min_units = min_units
    @per_unit_price = per_unit_price
  end

  def get_discount(checkout)
    item = checkout.sales[product_code]
    return unless applicable?(item)
    total_discount = discount(item)
    DiscountItem.new(item.product, item.quantity, total_discount)
  end

  private

  def applicable?(item)
    item && item.quantity >= min_units
  end

  def discount(item)
    item.total - (item.quantity * per_unit_price)
  end
end
