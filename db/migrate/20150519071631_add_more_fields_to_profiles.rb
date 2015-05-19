class AddMoreFieldsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :title, :string
    add_column :profiles, :company, :string
    add_column :profiles, :location, :string
    add_column :profiles, :linked_link, :string
    add_column :profiles, :summary, :text
  end
end
