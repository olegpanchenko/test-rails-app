class Discount < ApplicationRecord
  TYPES = %w(PercentageDiscount FixedDiscount)

  self.inheritance_column = :type

  belongs_to :order, optional: true

  scope :unused, -> { where(order_id: nil) }

  def calc_discount_for amount
    raise "Subclass must overwrite calc_discount_for"
  end
end
