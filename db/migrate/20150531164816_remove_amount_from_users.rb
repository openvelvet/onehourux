class RemoveAmountFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :amount, :string
    remove_column :users, :charge_id, :string
  end
end
