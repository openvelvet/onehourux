class AddIdFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :charge_id, :string
    add_column :orders, :amount, :integer
  end
end
