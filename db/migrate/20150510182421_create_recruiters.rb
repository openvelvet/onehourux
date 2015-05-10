class CreateRecruiters < ActiveRecord::Migration
  def change
    create_table :recruiters do |t|
      t.string :company_name
      t.string :company_location
      t.string :phone_number
      t.string :title

      t.timestamps null: false
    end
  end
end
