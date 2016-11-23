class RemoveReadFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :read, :boolean
  end
end
