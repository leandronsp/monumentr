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

ActiveRecord::Schema.define(version: 20141020103409) do

  create_table "collections", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "monument_pictures", force: true do |t|
    t.integer  "monument_id"
    t.string   "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "monument_pictures", ["monument_id", "picture_id"], name: "index_monument_pictures_on_monument_id_and_picture_id", unique: true

  create_table "monuments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "category"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "monuments", ["collection_id"], name: "index_monuments_on_collection_id"

  create_table "pictures", id: false, force: true do |t|
    t.string   "uuid",       null: false
    t.string   "extension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["uuid"], name: "index_pictures_on_uuid", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["encrypted_password"], name: "index_users_on_encrypted_password"

end
