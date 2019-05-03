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

ActiveRecord::Schema.define(version: 20190503025938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forecast_items", force: :cascade do |t|
    t.string "unix_time"
    t.integer "precip_chance"
    t.integer "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.string "from_number"
    t.string "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "query"
    t.integer "image_source"
    t.integer "status"
  end

  create_table "items", force: :cascade do |t|
    t.string "content", null: false
    t.string "todoist_id", null: false
    t.date "due"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
  end

  create_table "trivia_items", force: :cascade do |t|
    t.string "question", null: false
    t.string "answer", null: false
    t.string "response"
    t.integer "status"
    t.string "category", null: false
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "guess"
  end

end
