class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :profile, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :skills, :profiles
  end
end
