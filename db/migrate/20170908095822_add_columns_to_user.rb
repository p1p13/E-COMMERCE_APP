class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :permanent_address, :text
    add_column :users, :contact_number, :string
    add_column :users, :country_code, :string
  end
end
