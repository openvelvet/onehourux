class RemoveBuyerIdFromOrders < ActiveRecord::Migration
  def change
  	remove_column :customers, :buyer_id
  end
end
