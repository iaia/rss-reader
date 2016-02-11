class AddCollectionIdToSites < ActiveRecord::Migration
  def change
    add_column :sites, :collection_id, :integer
  end
end
