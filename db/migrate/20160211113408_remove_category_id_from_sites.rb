class RemoveCategoryIdFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :category_id, :string
  end
end
