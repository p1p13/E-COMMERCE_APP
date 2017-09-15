class ChangeCostFormatInOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :net_cost
    remove_column :cart_items, :cost
    remove_column :order_items, :integer
  end
end
