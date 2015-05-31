class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :orders, :zipe_code, :zip_code
  end
end
