require './models/promotion'

class BuyXforYPromotion < Promotion
  attr_reader :product_code, :buyX, :payY

  def initialize(product_code, buyX, payY)
    @product_code = product_code
    @buyX = buyX
    @payY = payY
  end

  def get_discount(checkout)
    item = checkout.sales[product_code]
    return unless applicable?(item)
    quantity = discount_quantity(item)
    discount_total = discount(item, quantity)
    DiscountItem.new(item.product, quantity, discount_total)
  end

  private

  def applicable?(item)
    item && item.quantity >= buyX
  end

  def discount_quantity(item)
    (item.quantity / buyX).floor * (buyX - payY)
  end

  def discount(item, quantity)
    quantity * item.price
  end
end
