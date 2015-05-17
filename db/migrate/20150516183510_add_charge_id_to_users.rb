class AddChargeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :charge_id, :string
  end
end
