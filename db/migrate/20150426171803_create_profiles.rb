class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :years_of_experience
      t.string :experience_level
      t.integer :price
      t.string :field

      t.timestamps null: false
    end
  end
end
