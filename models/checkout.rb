require './models/product_catalog'
require './models/item'
require './models/discount_item'

class Checkout
  attr_reader :items, :discounts, :catalog, :promotion_rules

  def initialize(promotion_rules = [])
    @items = {}
    @discounts = {}
    @catalog = ProductCatalog.instance
    @promotion_rules = promotion_rules
  end

  def scan(product_code)
    product = catalog.get(product_code)
    return add_product(product) if product
    puts "#{product_code} is not in catalog."
  end

  def total
    apply_promotions
    item_total - discount_total
  end

  private

    def item_total
      items.values.sum(&:total)
    end

    def discount_total
      discounts.values.sum(&:total)
    end

    def apply_promotions
      discounts.clear
      promotion_rules.each do |promotion|
        discount = promotion.get_discount(self)
        add_discount(discount) if discount
      end
    end

    def add_discount(discount)
      previous_discount = discounts[discount.code]
      if previous_discount.nil? || previous_discount.total < discount.total
        discounts[discount.code] = discount
      end
    end

    def add_product(product)
      if (item = items[product.code])
        item.increment_quantity
      else
        items[product.code] = Item.new(product)
      end
    end
end
