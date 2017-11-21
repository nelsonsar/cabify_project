require './models/promotion'

class BuyXforYPromotion < Promotion
  attr_reader :product_code, :buy_x, :pay_y

  def initialize(product_code, buy_x, pay_y)
    @product_code = product_code
    @buy_x = buy_x
    @pay_y = pay_y
  end

  def discount(checkout)
    item = checkout.sales[product_code]
    return unless applicable?(item)
    quantity = discount_quantity(item)
    Item.new(item.product, quantity, discount_total(item, quantity))
  end

  private

  def applicable?(item)
    item && item.quantity >= buy_x
  end

  def discount_quantity(item)
    (item.quantity / buy_x).floor * (buy_x - pay_y)
  end

  def discount_total(item, quantity)
    quantity * item.price
  end
end
