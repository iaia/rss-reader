class AddCollectionIdToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :collection_id, :integer
  end
end
