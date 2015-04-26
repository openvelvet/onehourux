class AddConnectionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :connections, :string
  end
end
