class AddDeletedColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :net_cost, :float
    add_column :cart_items, :cost, :float
  end
end
