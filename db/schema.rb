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

ActiveRecord::Schema[8.0].define(version: 2025_07_21_111640) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "idempotency_keys", force: :cascade do |t|
    t.text "key"
    t.string "method"
    t.text "endpoint"
    t.string "status_code"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.index ["key", "method", "endpoint"], name: "index_idempotency_keys_on_key_and_method_and_endpoint", unique: true
    t.index ["resource_type", "resource_id", "created_at"], name: "idx_on_resource_type_resource_id_created_at_d1925733a5"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_posts_on_status"
  end
end
