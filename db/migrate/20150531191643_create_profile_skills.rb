class CreateProfileSkills < ActiveRecord::Migration
  def change
    create_table :profile_skills do |t|
      t.belongs_to :profile, index: true
      t.belongs_to :skill, index: true

      t.timestamps null: false
    end
    add_foreign_key :profile_skills, :profiles
    add_foreign_key :profile_skills, :skills
  end
end
