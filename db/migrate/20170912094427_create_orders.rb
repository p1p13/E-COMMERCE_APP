class CreateOrders < ActiveRecord::Migration[5.1]
  #to do:cost should be float or new currency column should be added or any special data type should be used
  def change
    create_table :orders do |t|
      t.string :net_cost
      t.text :status
      t.string :transaction_id
      t.string :tax
      t.string :payment_mode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
