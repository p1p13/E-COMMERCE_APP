class CreateShippingDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_details do |t|
      t.string :address_line1
      t.string :address_line2
      t.string :address_line3
      t.string :zip
      t.string :country
      t.string :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
