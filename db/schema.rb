# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_22_055759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "name", default: "", null: false
    t.string "contact_number", default: "", null: false
    t.string "address", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["username"], name: "index_customers_on_username", unique: true
  end

  create_table "merchandisers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", default: "", null: false
    t.string "business_name", default: "", null: false
    t.string "owner_name", default: "", null: false
    t.string "business_number", default: "", null: false
    t.string "contact_number", default: "", null: false
    t.string "company_address", default: "", null: false
    t.integer "earnings", default: 0
    t.index ["business_name"], name: "index_merchandisers_on_business_name", unique: true
    t.index ["business_number"], name: "index_merchandisers_on_business_number", unique: true
    t.index ["email"], name: "index_merchandisers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_merchandisers_on_reset_password_token", unique: true
    t.index ["username"], name: "index_merchandisers_on_username", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "quantity", default: 0
    t.bigint "product_item_id", null: false
    t.bigint "purchase_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_item_id"], name: "index_orders_on_product_item_id"
    t.index ["purchase_id"], name: "index_orders_on_purchase_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.integer "total_amount"
    t.integer "buy_amount", default: 0
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["product_id"], name: "index_product_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.integer "shipping_fee", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.integer "category_id"
    t.bigint "merchandiser_id", null: false
    t.index ["merchandiser_id"], name: "index_products_on_merchandiser_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "purchase_number", default: "", null: false
    t.integer "shipping_fee", default: 0, null: false
    t.string "recipient_name", default: "", null: false
    t.string "recipient_contact", default: "", null: false
    t.string "recipient_address", default: "", null: false
    t.integer "shipping_status", default: 0
    t.integer "confirm_status", default: 0
    t.datetime "arrive_date"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_purchases_on_customer_id"
  end

  create_table "recent_views", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id", "product_id"], name: "index_recent_views_on_customer_id_and_product_id", unique: true
    t.index ["customer_id"], name: "index_recent_views_on_customer_id"
    t.index ["product_id"], name: "index_recent_views_on_product_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body", default: "", null: false
    t.integer "rating", default: 0
    t.string "image"
    t.bigint "order_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
    t.index ["order_id"], name: "index_reviews_on_order_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "orders", "product_items"
  add_foreign_key "orders", "purchases"
  add_foreign_key "product_items", "products"
  add_foreign_key "products", "merchandisers"
  add_foreign_key "purchases", "customers"
  add_foreign_key "recent_views", "customers"
  add_foreign_key "recent_views", "products"
  add_foreign_key "reviews", "customers"
  add_foreign_key "reviews", "orders"
end
