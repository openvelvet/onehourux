class AddLinkedinPhotoUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_photo_url, :string
  end
end
