class AddShippingDetailsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :shipping_details, foreign_key: true
  end
end
