class RemoveFeedUrlFromArticles < ActiveRecord::Migration[4.2]
  def change
    remove_column :articles, :feed_url, :string
  end
end
