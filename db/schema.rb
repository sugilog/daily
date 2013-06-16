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

ActiveRecord::Schema.define(version: 20130616015955) do

  create_table "dailylogs", force: true do |t|
    t.date     "logged_on",                          null: false
    t.decimal  "score",      precision: 7, scale: 2
    t.text     "memo"
    t.integer  "topic_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dailylogs", ["topic_id", "logged_on"], name: "index_dailylogs_on_topic_id_and_logged_on", unique: true

  create_table "topics", force: true do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
