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

ActiveRecord::Schema[7.1].define(version: 2024_03_29_114224) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "address"
    t.integer "zip"
    t.string "city"
    t.bigint "siret"
    t.boolean "is_pro"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "society_id", null: false
    t.string "business_name"
    t.string "email"
    t.string "country"
    t.index ["society_id"], name: "index_clients_on_society_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "content"
    t.datetime "issued_at", precision: nil
    t.datetime "due_at", precision: nil
    t.string "title"
    t.float "subtotal"
    t.float "tva"
    t.float "total"
    t.float "sale"
    t.boolean "is_draft"
    t.boolean "is_paid"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "society_id"
    t.string "number"
    t.bigint "client_id", null: false
    t.text "additional_info"
    t.string "category", default: "invoice"
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["society_id"], name: "index_invoices_on_society_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "registers", force: :cascade do |t|
    t.datetime "paid_at"
    t.bigint "society_id", null: false
    t.bigint "invoice_id"
    t.float "amount"
    t.text "title"
    t.text "comment"
    t.string "payment_method"
    t.boolean "is_income", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_registers_on_invoice_id"
    t.index ["society_id"], name: "index_registers_on_society_id"
  end

  create_table "societies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "zip"
    t.string "city"
    t.string "country"
    t.bigint "siret"
    t.string "status"
    t.integer "capital"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["siret"], name: "index_societies_on_siret", unique: true
    t.index ["user_id"], name: "index_societies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "societies"
  add_foreign_key "clients", "users"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "societies"
  add_foreign_key "invoices", "users"
  add_foreign_key "registers", "invoices"
  add_foreign_key "registers", "societies"
  add_foreign_key "societies", "users"
end
