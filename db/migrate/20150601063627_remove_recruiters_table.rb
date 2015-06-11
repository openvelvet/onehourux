class RemoveRecruitersTable < ActiveRecord::Migration
  def change
  	drop_table :recruiters
  end
end
