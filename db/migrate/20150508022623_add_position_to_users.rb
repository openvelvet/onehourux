class AddPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_position, :string
  end
end
