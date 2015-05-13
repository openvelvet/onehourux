class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zipe_code

      t.timestamps null: false
    end
  end
end
