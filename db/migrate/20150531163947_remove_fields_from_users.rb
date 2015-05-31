class RemoveFieldsFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :image_file_name
  	remove_column :users, :image_file_size
  	remove_column :users, :image_updated_at
  	remove_column :users, :image_content_type
  end
end
