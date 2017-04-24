class PercentageDiscount < Discount
  def calc_discount_for amount
    amount * value / 100.0
  end
end
