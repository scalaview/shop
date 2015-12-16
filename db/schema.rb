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

ActiveRecord::Schema.define(version: 20151216090107) do

  create_table "nifty_key_value_store", force: :cascade do |t|
    t.integer "parent_id",   limit: 4
    t.string  "parent_type", limit: 255
    t.string  "group",       limit: 255
    t.string  "name",        limit: 255
    t.string  "value",       limit: 255
  end

  create_table "shoppe_addresses", force: :cascade do |t|
    t.integer  "customer_id",   limit: 4
    t.string   "address_type",  limit: 255
    t.boolean  "default"
    t.string   "address1",      limit: 255
    t.string   "address2",      limit: 255
    t.string   "address3",      limit: 255
    t.string   "address4",      limit: 255
    t.string   "postcode",      limit: 255
    t.integer  "country_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "province",      limit: 255
    t.string   "city",          limit: 255
    t.string   "area",          limit: 255
    t.string   "street",        limit: 255
    t.string   "md5",           limit: 255
    t.string   "location",      limit: 255
    t.string   "phone",         limit: 255
    t.string   "receiver_name", limit: 255
  end

  add_index "shoppe_addresses", ["customer_id"], name: "index_shoppe_addresses_on_customer_id", using: :btree

  create_table "shoppe_attachments", force: :cascade do |t|
    t.integer  "parent_id",   limit: 4,   null: false
    t.string   "parent_type", limit: 255, null: false
    t.string   "token",       limit: 255
    t.string   "file",        limit: 255, null: false
    t.string   "file_name",   limit: 255
    t.integer  "file_size",   limit: 4
    t.string   "file_type",   limit: 255
    t.string   "role",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppe_basket_items", force: :cascade do |t|
    t.integer  "customer_id", limit: 4,             null: false
    t.integer  "product_id",  limit: 4,             null: false
    t.integer  "quantity",    limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_basket_items", ["customer_id"], name: "index_shoppe_basket_items_on_customer_id", using: :btree
  add_index "shoppe_basket_items", ["product_id"], name: "index_shoppe_basket_items_on_product_id", using: :btree

  create_table "shoppe_countries", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.string  "code2",     limit: 255
    t.string  "code3",     limit: 255
    t.string  "continent", limit: 255
    t.string  "tld",       limit: 255
    t.string  "currency",  limit: 255
    t.boolean "eu_member",             default: false
  end

  create_table "shoppe_customers", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "company",         limit: 255
    t.string   "email",           limit: 255
    t.string   "phone",           limit: 255
    t.string   "mobile",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.string   "wxid",            limit: 255
  end

  create_table "shoppe_delivery_service_prices", force: :cascade do |t|
    t.integer  "delivery_service_id", limit: 4
    t.string   "code",                limit: 255
    t.decimal  "price",                             precision: 8, scale: 2
    t.decimal  "cost_price",                        precision: 8, scale: 2
    t.integer  "tax_rate_id",         limit: 4
    t.decimal  "min_weight",                        precision: 8, scale: 2
    t.decimal  "max_weight",                        precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "country_ids",         limit: 65535
  end

  add_index "shoppe_delivery_service_prices", ["delivery_service_id"], name: "index_shoppe_delivery_service_prices_on_delivery_service_id", using: :btree
  add_index "shoppe_delivery_service_prices", ["max_weight"], name: "index_shoppe_delivery_service_prices_on_max_weight", using: :btree
  add_index "shoppe_delivery_service_prices", ["min_weight"], name: "index_shoppe_delivery_service_prices_on_min_weight", using: :btree
  add_index "shoppe_delivery_service_prices", ["price"], name: "index_shoppe_delivery_service_prices_on_price", using: :btree

  create_table "shoppe_delivery_services", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "code",         limit: 255
    t.boolean  "default",                  default: false
    t.boolean  "active",                   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "courier",      limit: 255
    t.string   "tracking_url", limit: 255
  end

  add_index "shoppe_delivery_services", ["active"], name: "index_shoppe_delivery_services_on_active", using: :btree

  create_table "shoppe_order_addresses", force: :cascade do |t|
    t.string   "address_type",  limit: 255
    t.string   "province",      limit: 255
    t.string   "city",          limit: 255
    t.string   "area",          limit: 255
    t.string   "street",        limit: 255
    t.string   "location",      limit: 255
    t.string   "postcode",      limit: 255
    t.integer  "country_id",    limit: 4
    t.integer  "address_id",    limit: 4
    t.string   "md5",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",         limit: 255
    t.string   "receiver_name", limit: 255
  end

  add_index "shoppe_order_addresses", ["address_id"], name: "index_shoppe_order_addresses_on_address_id", using: :btree

  create_table "shoppe_order_items", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.integer  "ordered_item_id",   limit: 4
    t.string   "ordered_item_type", limit: 255
    t.integer  "quantity",          limit: 4,                           default: 1
    t.decimal  "unit_price",                    precision: 8, scale: 2
    t.decimal  "unit_cost_price",               precision: 8, scale: 2
    t.decimal  "tax_amount",                    precision: 8, scale: 2
    t.decimal  "tax_rate",                      precision: 8, scale: 2
    t.decimal  "weight",                        precision: 8, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_order_items", ["order_id"], name: "index_shoppe_order_items_on_order_id", using: :btree
  add_index "shoppe_order_items", ["ordered_item_id", "ordered_item_type"], name: "index_shoppe_order_items_ordered_item", using: :btree

  create_table "shoppe_orders", force: :cascade do |t|
    t.string   "token",                     limit: 255
    t.string   "first_name",                limit: 255
    t.string   "last_name",                 limit: 255
    t.string   "company",                   limit: 255
    t.string   "billing_address1",          limit: 255
    t.string   "billing_address2",          limit: 255
    t.string   "billing_address3",          limit: 255
    t.string   "billing_address4",          limit: 255
    t.string   "billing_postcode",          limit: 255
    t.integer  "billing_country_id",        limit: 4
    t.string   "email_address",             limit: 255
    t.string   "phone_number",              limit: 255
    t.string   "status",                    limit: 255,                                           null: false
    t.datetime "received_at"
    t.datetime "accepted_at"
    t.datetime "shipped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delivery_service_id",       limit: 4
    t.decimal  "delivery_price",                          precision: 8, scale: 2
    t.decimal  "delivery_cost_price",                     precision: 8, scale: 2
    t.decimal  "delivery_tax_rate",                       precision: 8, scale: 2
    t.decimal  "delivery_tax_amount",                     precision: 8, scale: 2
    t.integer  "accepted_by",               limit: 4
    t.integer  "shipped_by",                limit: 4
    t.string   "consignment_number",        limit: 255
    t.datetime "rejected_at"
    t.integer  "rejected_by",               limit: 4
    t.string   "ip_address",                limit: 255
    t.text     "notes",                     limit: 65535
    t.boolean  "separate_delivery_address",                                       default: false
    t.string   "delivery_name",             limit: 255
    t.string   "delivery_address1",         limit: 255
    t.string   "delivery_address2",         limit: 255
    t.string   "delivery_address3",         limit: 255
    t.string   "delivery_address4",         limit: 255
    t.string   "delivery_postcode",         limit: 255
    t.integer  "delivery_country_id",       limit: 4
    t.decimal  "amount_paid",                             precision: 8, scale: 2, default: 0.0
    t.boolean  "exported",                                                        default: false
    t.string   "invoice_number",            limit: 255
    t.integer  "customer_id",               limit: 4
    t.integer  "delivery_address_id",       limit: 4
    t.integer  "billing_address_id",        limit: 4
    t.integer  "payment_method_id",         limit: 4
  end

  add_index "shoppe_orders", ["delivery_service_id"], name: "index_shoppe_orders_on_delivery_service_id", using: :btree
  add_index "shoppe_orders", ["received_at"], name: "index_shoppe_orders_on_received_at", using: :btree
  add_index "shoppe_orders", ["token"], name: "index_shoppe_orders_on_token", using: :btree

  create_table "shoppe_payment_methods", force: :cascade do |t|
    t.string   "name",        limit: 255,                                        null: false
    t.string   "code",        limit: 255,                                        null: false
    t.decimal  "poundage",                precision: 8, scale: 2, default: 0.0
    t.integer  "currency_id", limit: 4
    t.boolean  "display",                                         default: true, null: false
    t.integer  "sort_num",    limit: 4,                           default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppe_payments", force: :cascade do |t|
    t.integer  "order_id",          limit: 4
    t.decimal  "amount",                        precision: 8, scale: 2, default: 0.0
    t.string   "reference",         limit: 255
    t.string   "method",            limit: 255
    t.boolean  "confirmed",                                             default: true
    t.boolean  "refundable",                                            default: false
    t.decimal  "amount_refunded",               precision: 8, scale: 2, default: 0.0
    t.integer  "parent_payment_id", limit: 4
    t.boolean  "exported",                                              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_payments", ["order_id"], name: "index_shoppe_payments_on_order_id", using: :btree
  add_index "shoppe_payments", ["parent_payment_id"], name: "index_shoppe_payments_on_parent_payment_id", using: :btree

  create_table "shoppe_product_attributes", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.integer  "position",   limit: 4,   default: 1
    t.boolean  "searchable",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",                 default: true
  end

  add_index "shoppe_product_attributes", ["key"], name: "index_shoppe_product_attributes_on_key", using: :btree
  add_index "shoppe_product_attributes", ["position"], name: "index_shoppe_product_attributes_on_position", using: :btree
  add_index "shoppe_product_attributes", ["product_id"], name: "index_shoppe_product_attributes_on_product_id", using: :btree

  create_table "shoppe_product_categories", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "permalink",                    limit: 255
    t.text     "description",                  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",                    limit: 4
    t.integer  "lft",                          limit: 4
    t.integer  "rgt",                          limit: 4
    t.integer  "depth",                        limit: 4
    t.string   "ancestral_permalink",          limit: 255
    t.boolean  "permalink_includes_ancestors",               default: false
  end

  add_index "shoppe_product_categories", ["lft"], name: "index_shoppe_product_categories_on_lft", using: :btree
  add_index "shoppe_product_categories", ["permalink"], name: "index_shoppe_product_categories_on_permalink", using: :btree
  add_index "shoppe_product_categories", ["rgt"], name: "index_shoppe_product_categories_on_rgt", using: :btree

  create_table "shoppe_product_categorizations", force: :cascade do |t|
    t.integer "product_id",          limit: 4, null: false
    t.integer "product_category_id", limit: 4, null: false
  end

  add_index "shoppe_product_categorizations", ["product_category_id"], name: "categorization_by_product_category_id", using: :btree
  add_index "shoppe_product_categorizations", ["product_id"], name: "categorization_by_product_id", using: :btree

  create_table "shoppe_product_category_translations", force: :cascade do |t|
    t.integer  "shoppe_product_category_id", limit: 4,     null: false
    t.string   "locale",                     limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                       limit: 255
    t.string   "permalink",                  limit: 255
    t.text     "description",                limit: 65535
  end

  add_index "shoppe_product_category_translations", ["locale"], name: "index_shoppe_product_category_translations_on_locale", using: :btree
  add_index "shoppe_product_category_translations", ["shoppe_product_category_id"], name: "index_75826cc72f93d014e54dc08b8202892841c670b4", using: :btree

  create_table "shoppe_product_translations", force: :cascade do |t|
    t.integer  "shoppe_product_id", limit: 4,     null: false
    t.string   "locale",            limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",              limit: 255
    t.string   "permalink",         limit: 255
    t.text     "description",       limit: 65535
    t.text     "short_description", limit: 65535
  end

  add_index "shoppe_product_translations", ["locale"], name: "index_shoppe_product_translations_on_locale", using: :btree
  add_index "shoppe_product_translations", ["shoppe_product_id"], name: "index_shoppe_product_translations_on_shoppe_product_id", using: :btree

  create_table "shoppe_product_variant_values", force: :cascade do |t|
    t.integer  "stockkeeping_unit_id", limit: 4, null: false
    t.integer  "variant_value_id",     limit: 4, null: false
    t.integer  "variant_type_id",      limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_product_variant_values", ["stockkeeping_unit_id"], name: "index_shoppe_product_variant_values_on_stockkeeping_unit_id", using: :btree
  add_index "shoppe_product_variant_values", ["variant_type_id"], name: "index_shoppe_product_variant_values_on_variant_type_id", using: :btree
  add_index "shoppe_product_variant_values", ["variant_value_id"], name: "index_shoppe_product_variant_values_on_variant_value_id", using: :btree

  create_table "shoppe_products", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "permalink",                    limit: 255
    t.text     "description",                  limit: 65535
    t.text     "short_description",            limit: 65535
    t.boolean  "active",                                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",                                   default: false
    t.text     "in_the_box",                   limit: 65535
    t.integer  "default_stockkeeping_unit_id", limit: 4
  end

  add_index "shoppe_products", ["default_stockkeeping_unit_id"], name: "index_shoppe_products_on_default_stockkeeping_unit_id", using: :btree
  add_index "shoppe_products", ["permalink"], name: "index_shoppe_products_on_permalink", using: :btree

  create_table "shoppe_regions", force: :cascade do |t|
    t.string   "code",       limit: 255, null: false
    t.string   "parentcode", limit: 255
    t.string   "name",       limit: 255, null: false
    t.integer  "level",      limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_regions", ["code"], name: "index_shoppe_regions_on_code", using: :btree
  add_index "shoppe_regions", ["level"], name: "index_shoppe_regions_on_level", using: :btree
  add_index "shoppe_regions", ["parentcode"], name: "index_shoppe_regions_on_parentcode", using: :btree

  create_table "shoppe_settings", force: :cascade do |t|
    t.string "key",        limit: 255
    t.string "value",      limit: 255
    t.string "value_type", limit: 255
  end

  add_index "shoppe_settings", ["key"], name: "index_shoppe_settings_on_key", using: :btree

  create_table "shoppe_stock_level_adjustments", force: :cascade do |t|
    t.integer  "item_id",     limit: 4
    t.string   "item_type",   limit: 255
    t.string   "description", limit: 255
    t.integer  "adjustment",  limit: 4,   default: 0
    t.string   "parent_type", limit: 255
    t.integer  "parent_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_stock_level_adjustments", ["item_id", "item_type"], name: "index_shoppe_stock_level_adjustments_items", using: :btree
  add_index "shoppe_stock_level_adjustments", ["parent_id", "parent_type"], name: "index_shoppe_stock_level_adjustments_parent", using: :btree

  create_table "shoppe_stockkeeping_units", force: :cascade do |t|
    t.string   "product_id",    limit: 255,                                        null: false
    t.string   "sku",           limit: 255
    t.boolean  "active",                                            default: true
    t.boolean  "stock_control",                                     default: true
    t.decimal  "weight",                    precision: 8, scale: 3, default: 0.0
    t.decimal  "cost_price",                precision: 8, scale: 3, default: 0.0
    t.decimal  "price",                     precision: 8, scale: 3, default: 0.0
    t.integer  "tax_rate_id",   limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_stockkeeping_units", ["active"], name: "index_shoppe_stockkeeping_units_on_active", using: :btree
  add_index "shoppe_stockkeeping_units", ["deleted_at"], name: "index_shoppe_stockkeeping_units_on_deleted_at", using: :btree
  add_index "shoppe_stockkeeping_units", ["product_id"], name: "index_shoppe_stockkeeping_units_on_product_id", using: :btree
  add_index "shoppe_stockkeeping_units", ["stock_control"], name: "index_shoppe_stockkeeping_units_on_stock_control", using: :btree

  create_table "shoppe_tax_rates", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.decimal  "rate",                       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "country_ids",  limit: 65535
    t.string   "address_type", limit: 255
  end

  create_table "shoppe_users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email_address",   limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_users", ["email_address"], name: "index_shoppe_users_on_email_address", using: :btree

  create_table "shoppe_variant_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoppe_variant_values", force: :cascade do |t|
    t.integer  "variant_type_id", limit: 4
    t.string   "name",            limit: 255
    t.integer  "position",        limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shoppe_variant_values", ["position"], name: "index_shoppe_variant_values_on_position", using: :btree
  add_index "shoppe_variant_values", ["variant_type_id"], name: "index_shoppe_variant_values_on_variant_type_id", using: :btree

end
