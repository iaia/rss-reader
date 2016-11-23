class CreateArticleUsers < ActiveRecord::Migration
  def change
    create_table :article_users do |t|
      t.references :article, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
