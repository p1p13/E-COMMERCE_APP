class CreateCartItems < ActiveRecord::Migration[5.1]
    #to do:cost should be float or new currency column should be added or any special data type should be used

  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.string :cost
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
