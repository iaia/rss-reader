class RemoveUserIdFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :user_id, :integer
  end
end
