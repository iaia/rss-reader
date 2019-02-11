class RemoveEntryIdFromArticles < ActiveRecord::Migration[4.2]
  def change
    remove_column :articles, :entry_id, :string
  end
end
