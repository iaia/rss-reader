# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2016_11_27_120327) do

  create_table "article_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "article_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_users_on_article_id"
    t.index ["user_id"], name: "index_article_users_on_user_id"
  end

  create_table "articles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "content"
    t.datetime "published"
    t.integer "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "collections", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "site_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_site_users_on_site_id"
    t.index ["user_id"], name: "index_site_users_on_user_id"
  end

  create_table "sites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "feed_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "collection_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "meta"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_users", "articles"
  add_foreign_key "article_users", "users"
  add_foreign_key "site_users", "sites"
  add_foreign_key "site_users", "users"
end
