class AddAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_account, :string
  end
end
