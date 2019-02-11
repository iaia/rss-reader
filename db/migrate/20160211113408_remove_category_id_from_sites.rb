class RemoveCategoryIdFromSites < ActiveRecord::Migration[4.2]
  def change
    remove_column :sites, :category_id, :string
  end
end
