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

ActiveRecord::Schema.define(version: 20140307013932) do

  create_table "authors", force: true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_shelves", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.date     "publish_date"
    t.string   "genre"
    t.text     "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "summary"
  end

  create_table "chapters", force: true do |t|
    t.string   "title"
    t.integer  "book_id"
    t.text     "description"
    t.text     "content_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  create_table "comments", force: true do |t|
    t.text     "description"
    t.date     "publish_date"
    t.integer  "user_id"
    t.integer  "chapter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "description"
    t.date     "publish_date"
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.text     "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "wish_lists", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
