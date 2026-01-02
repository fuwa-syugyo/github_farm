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

ActiveRecord::Schema[8.1].define(version: 2026_01_02_132942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "animals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "escape_days"
    t.string "image_url"
    t.string "name"
    t.integer "recovery_days"
    t.datetime "updated_at", null: false
  end

  create_table "notification_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.integer "notification_type"
    t.integer "notify_hour"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_notification_settings_on_user_id"
  end

  create_table "user_animal_stats", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.integer "recovered_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["animal_id"], name: "index_user_animal_stats_on_animal_id"
    t.index ["user_id", "animal_id"], name: "index_user_animal_stats_on_user_id_and_animal_id", unique: true
    t.index ["user_id"], name: "index_user_animal_stats_on_user_id"
  end

  create_table "user_animals", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.integer "feed_days", default: 0, null: false
    t.date "last_feed_date"
    t.date "start_feed_date"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["animal_id"], name: "index_user_animals_on_animal_id"
    t.index ["user_id"], name: "index_user_animals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_url"
    t.date "last_contribution_date"
    t.datetime "last_grass_check_date"
    t.string "name", null: false
    t.integer "recovered_animal_count", default: 0, null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "notification_settings", "users"
  add_foreign_key "user_animal_stats", "animals"
  add_foreign_key "user_animal_stats", "users"
  add_foreign_key "user_animals", "animals"
  add_foreign_key "user_animals", "users"
end
