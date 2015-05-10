class AddUserIdToRecruiters < ActiveRecord::Migration
  def change
    add_column :recruiters, :user_id, :integer
  end
end
