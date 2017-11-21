require './models/promotion'

class BulkPerUnitPromotion < Promotion
  attr_reader :product_code, :min_units, :per_unit_price

  def initialize(product_code, min_units, per_unit_price)
    @product_code = product_code
    @min_units = min_units
    @per_unit_price = per_unit_price
  end

  def discount(checkout)
    item = checkout.sales[product_code]
    return unless applicable?(item)
    Item.new(item.product, item.quantity, discount_total(item))
  end

  private

  def applicable?(item)
    item && item.quantity >= min_units
  end

  def discount_total(item)
    item.total - (item.quantity * per_unit_price)
  end
end
