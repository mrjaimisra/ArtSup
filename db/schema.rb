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

ActiveRecord::Schema.define(version: 20151125190346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists_to_supporters", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "supporter_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "zipcode"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "token"
    t.string   "uid"
    t.string   "image_url"
    t.string   "wishlist_id"
    t.text     "story"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "url"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.integer  "gallery_id"
    t.string   "gift"
  end

end
