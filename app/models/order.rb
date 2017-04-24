class Order < ApplicationRecord
  enum status: [ :draft, :paid ]

  has_many :order_items
  has_many :discounts

  attr_accessor :card_number, :month, :year, :verification_value
  validates :email, :address, :city, :state, :zip, :card_number, :month, :year, :verification_value, presence: true, if: Proc.new{|x| x.paid? }

  before_save :make_payment, if: Proc.new{|x| x.paid? }

  def apply_promotion! promo_code
    applied = false
    discount = Discount.unused.find_by promo_code: promo_code
    if discount
      self.association(:discounts).add_to_target(discount)
      # if promotion can be used in conjunction with other codes
      if (discounts.size < 2 || discounts.map(&:can_be_conjunction).all?)
        self.discounts << discount
        applied = true
      else
        self.reload
      end
    end

    errors.add( :base, 'Promotions cannot be applied' ) if !applied

    applied
  end

  def make_payment
    self.amount = calc_amount

  end

  def calc_amount
    cost = 0
    self.order_items.each do |order_item|
      cost += order_item.quantity*order_item.item.price
    end

    total_discount = 0
    self.discounts.each do |discount|
      total_discount += discount.calc_discount_for(cost)
    end

    cost -= total_discount
    cost < 0 ? 0.0 : cost
  end

end
