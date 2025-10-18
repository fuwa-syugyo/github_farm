# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_17_151320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.integer "recovery_days"
    t.integer "escape_days"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_animals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "animal_id", null: false
    t.integer "status"
    t.date "start_feed_date"
    t.date "last_feed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_user_animals_on_animal_id"
    t.index ["user_id"], name: "index_user_animals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "github_user_id"
    t.integer "recovered_animal_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "user_animals", "animals"
  add_foreign_key "user_animals", "users"
end
