class RemoveEntryIdFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :entry_id, :string
  end
end
