class RemoveFeedUrlFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :feed_url, :string
  end
end
