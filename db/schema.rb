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

ActiveRecord::Schema.define(version: 20140904025027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certifieds", force: true do |t|
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "background_url"
    t.string   "name_color"
    t.string   "events"
    t.text     "attendees"
  end

  add_index "certifieds", ["user_id"], name: "index_certifieds_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
