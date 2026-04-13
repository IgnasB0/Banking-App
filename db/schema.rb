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

ActiveRecord::Schema[8.1].define(version: 2026_04_13_113435) do
  create_table "accounts", force: :cascade do |t|
    t.string "country_code"
    t.datetime "created_at", null: false
    t.string "first_name"
    t.string "iban"
    t.string "last_name"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["iban"], name: "index_accounts_on_iban", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "banking_facilities", force: :cascade do |t|
    t.string "api_key_digest"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "amount"
    t.integer "banking_facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_deposits_on_account_id"
    t.index ["banking_facility_id"], name: "index_deposits_on_banking_facility_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.integer "from_account_id", null: false
    t.integer "to_account_id", null: false
    t.datetime "updated_at", null: false
    t.index ["from_account_id"], name: "index_transfers_on_from_account_id"
    t.index ["to_account_id"], name: "index_transfers_on_to_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "withdrawals", force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "amount"
    t.integer "banking_facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_withdrawals_on_account_id"
    t.index ["banking_facility_id"], name: "index_withdrawals_on_banking_facility_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "deposits", "accounts"
  add_foreign_key "deposits", "banking_facilities"
  add_foreign_key "sessions", "users"
  add_foreign_key "transfers", "accounts", column: "from_account_id"
  add_foreign_key "transfers", "accounts", column: "to_account_id"
  add_foreign_key "withdrawals", "accounts"
  add_foreign_key "withdrawals", "banking_facilities"
end
