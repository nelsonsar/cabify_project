class BuyXforYPromotion < Promotion
  attr_reader :product_code, :buyX, :payY

  def initialize(product_code, buyX, payY)
    @product_code = product_code
    @buyX = buyX
    @payY = payY
  end

  def apply(checkout)
    item = checkout.items[product_code]
    return unless appliable?(item)
    quantity = discount_quantity(item)
    discount_total = discount(item, quantity)
    checkout.add_discount(item, quantity, discount_total)
  end

  private

  def appliable?(item)
    item && item.quantity >= buyX
  end

  def discount_quantity(item)
    (item.quantity / buyX).floor * (buyX - payY)
  end

  def discount(item, quantity)
    quantity * item.price
  end
end
