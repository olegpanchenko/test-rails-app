class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :status
      t.string :charge_id
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
