class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :promo_code
      t.references :order, foreign_key: true
      t.boolean :can_be_conjunction
      t.decimal :value, precision: 8, scale: 2
      t.string :type

      t.timestamps
    end
  end
end
