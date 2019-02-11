class CreateArticles < ActiveRecord::Migration[4.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :entry_id
      t.string :url
      t.string :feed_url
      t.string :content
      t.datetime :published
      t.boolean :read, default: false, null: false
      t.integer :site_id

      t.timestamps null: false
    end
  end
end
