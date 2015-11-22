class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.string :feed_url
      t.integer :category_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
