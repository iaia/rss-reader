# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161123154553) do

  create_table "article_users", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "article_users", ["article_id"], name: "index_article_users_on_article_id"
  add_index "article_users", ["user_id"], name: "index_article_users_on_user_id"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "content"
    t.datetime "published"
    t.integer  "site_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_users", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "site_users", ["site_id"], name: "index_site_users_on_site_id"
  add_index "site_users", ["user_id"], name: "index_site_users_on_user_id"

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "feed_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "collection_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
