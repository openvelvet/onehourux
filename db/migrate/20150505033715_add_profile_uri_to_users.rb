class AddProfileUriToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_uri, :string
  end
end
