class TwoForOne < Promotion
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def apply(checkout)
    item = checkout.items[code]
    return unless item && item.quantity >= 2
    discount_quantity = (item.quantity / 2).floor
    discount_total = discount_quantity * item.price
    checkout.add_discount(item, discount_quantity, discount_total)
  end
end
