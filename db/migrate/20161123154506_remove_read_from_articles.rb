class RemoveReadFromArticles < ActiveRecord::Migration[4.2]
  def change
    remove_column :articles, :read, :boolean
  end
end
