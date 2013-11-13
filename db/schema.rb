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

ActiveRecord::Schema.define(version: 20131113221047) do

  create_table "bizs", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "logo_image"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "shoppers", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "home_page"
    t.string   "zip_code"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
