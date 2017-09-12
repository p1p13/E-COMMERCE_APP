class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :in_stock
      t.float :cost

      t.timestamps
    end
  end
end
